{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (zenn-cli.overrideAttrs (oldAttrs: rec {
      pname = "zenn-cli";
      version = "0.4.5";

      src = pkgs.fetchFromGitHub {
        owner = "zenn-dev";
        repo = "zenn-editor";
        rev = "v${version}";
        hash = "sha256-hX+bb6eEHzzWKhmXkHoaM6197rVhMFG8vO6nJ2+1bVY=";
      };

      pnpmDeps = pkgs.pnpm_10.fetchDeps {
        inherit pname version src;
        hash = "sha256-hCseIc9TPRdGTDvL7M5ewrvgb/jj+QPNvd1lR/DwCgc=";
        fetcherVersion = 2; # pnpm の依存関係取得方法のバージョン 2:新しい方式
      };
    }))
  ];
}
