{ config, pkgs, lib, ... }:

let
  # md-to-pdf は puppeteer 経由で Chrome/Chromium を使う。
  # Chromium は Darwin でビルドできないため、Mac では Homebrew 等で入れた
  # Google Chrome.app を、Linux では pkgs.chromium を使う。
  chromePath =
    if pkgs.stdenv.isDarwin then
      "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    else
      "${pkgs.chromium}/bin/chromium";

  md-to-pdf-unwrapped = pkgs.buildNpmPackage rec {
    pname = "md-to-pdf";
    version = "5.2.5";

    src = pkgs.fetchFromGitHub {
      owner = "simonhaenisch";
      repo = "md-to-pdf";
      rev = "v${version}";
      hash = "sha256-6Zr4jidQ6cX2t6jKFqEnCSqvRtw4gZkqDKdv9SIyDC4=";
    };

    npmDepsHash = "sha256-AGn8g/nbkvWi4o6ENCnt7VexjfBIoDz+tl9eYvy+bao=";

    # puppeteer が postinstall で Chromium をダウンロードするのを止める。
    # あわせて devDependency の canvas の native build (node-gyp) も回避する。
    env.PUPPETEER_SKIP_DOWNLOAD = "1";
    npmFlags = [ "--ignore-scripts" ];

    dontNpmPrune = true;

    meta = {
      description = "CLI tool for converting Markdown files to PDF";
      homepage = "https://github.com/simonhaenisch/md-to-pdf";
      license = lib.licenses.mit;
      mainProgram = "md-to-pdf";
    };
  };

  # GitHub 記法の alert (> [!NOTE] 等) を marked の拡張として追加する。
  # 依存ゼロで npm tarball に dist/ がビルド済みで入っており、lockfile も無いので
  # buildNpmPackage は使わず、展開して置くだけでよい。
  #
  # marked-alert は peer に marked >=7 を宣言しているが、md-to-pdf の marked は v4 系。
  # marked-alert は marked を require しておらず (peer 宣言のみ)、使う API は walkTokens と
  # extension renderer 内の this.parser だけで、marked v4.3.0 はどちらも満たすため実際には動く。
  # md-to-pdf 本体が marked v4 の API で書かれている以上、marked を上げてはいけない。
  marked-alert = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "marked-alert";
    version = "2.1.2";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/marked-alert/-/marked-alert-${version}.tgz";
      hash = "sha256-bo6TuyCwwPwAPlx0kN6c/UEMd84nKC3fGlxtfFkMEzo=";
    };

    # npm の tarball は package/ 直下に展開される
    sourceRoot = "package";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib/node_modules/marked-alert
      cp -r . $out/lib/node_modules/marked-alert/
      runHook postInstall
    '';

    meta = {
      description = "Marked extension for GitHub-style alerts";
      homepage = "https://github.com/bent10/marked-extensions/tree/main/packages/alert";
      license = lib.licenses.mit;
    };
  };

  # marked-alert は div.markdown-alert / p.markdown-alert-title を出すだけでスタイルを持たず、
  # md-to-pdf 同梱の markdown.css にも該当スタイルは無いため、GitHub 相当の見た目をここで与える。
  # アイコンの svg は fill 指定を持たないので、title の color が currentColor 経由で効く。
  alertCss = pkgs.writeText "markdown-alert.css" ''
    .markdown-alert {
      padding: 0.5rem 1rem;
      margin-bottom: 1rem;
      border-left: 0.25em solid;
    }

    .markdown-alert > :first-child {
      margin-top: 0;
    }

    .markdown-alert > :last-child {
      margin-bottom: 0;
    }

    .markdown-alert-title {
      display: flex;
      align-items: center;
      font-weight: 600;
      line-height: 1;
    }

    .markdown-alert-title svg {
      margin-right: 0.5rem;
      fill: currentColor;
    }

    .markdown-alert-note {
      border-left-color: #0969da;
      background-color: #ddf4ff40;
    }
    .markdown-alert-note .markdown-alert-title { color: #0969da; }

    .markdown-alert-tip {
      border-left-color: #1a7f37;
      background-color: #dafbe140;
    }
    .markdown-alert-tip .markdown-alert-title { color: #1a7f37; }

    .markdown-alert-important {
      border-left-color: #8250df;
      background-color: #fbefff40;
    }
    .markdown-alert-important .markdown-alert-title { color: #8250df; }

    .markdown-alert-warning {
      border-left-color: #9a6700;
      background-color: #fff8c540;
    }
    .markdown-alert-warning .markdown-alert-title { color: #9a6700; }

    .markdown-alert-caution {
      border-left-color: #cf222e;
      background-color: #ffebe940;
    }
    .markdown-alert-caution .markdown-alert-title { color: #cf222e; }
  '';

  # md-to-pdf は config ファイルを require(path.resolve(...)) で読むだけなので、
  # store の絶対パスを require しておけば NODE_PATH に頼らず確実に解決できる。
  mdToPdfConfig = pkgs.writeText "md-to-pdf-config.js" ''
    const markedAlert = require("${marked-alert}/lib/node_modules/marked-alert");

    module.exports = {
      marked_extensions: [markedAlert()],

      // md-to-pdf の config はシャローマージ (cli.ts の {...config, ...configFile}) なので、
      // stylesheet を指定すると既定の markdown.css が置き換わってしまう。両方を明示する。
      stylesheet: [
        "${md-to-pdf-unwrapped}/lib/node_modules/md-to-pdf/markdown.css",
        "${alertCss}",
      ],
    };
  '';

  # 上の config が md-to-pdf 自身の store path を参照するため、derivation を2段に分ける
  # (同一 derivation 内で自分の $out を config に埋めると循環する)。
  md-to-pdf = pkgs.symlinkJoin {
    name = "md-to-pdf-${md-to-pdf-unwrapped.version}";
    paths = [ md-to-pdf-unwrapped ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    # --add-flags はユーザーの引数より前に入り、md-to-pdf が使う arg は後勝ちなので、
    # 自分で --config-file を渡せばそちらが優先される (その場合 alert は無効になるので、
    # 独自 config から上の config を require して spread すればよい)。
    postBuild = ''
      for bin in md-to-pdf md2pdf; do
        wrapProgram $out/bin/$bin \
          --set-default PUPPETEER_EXECUTABLE_PATH "${chromePath}" \
          --add-flags "--config-file ${mdToPdfConfig}"
      done
    '';

    inherit (md-to-pdf-unwrapped) meta;
  };
in
{
  home.packages = [ md-to-pdf ];
}
