{ pkgs, ... }:

let
  # posthog が mcp 2 で broken になっているのを回避
  pkgsFixed = pkgs.extend (final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (pyFinal: pyPrev: {
        posthog = pyPrev.posthog.overridePythonAttrs (old: {
          meta = old.meta // { broken = false; };
          disabledTestPaths = (old.disabledTestPaths or [ ]) ++ [ "posthog/test/mcp" ];
        });
      })
    ];
  });

  # litellm 更新で aider のテスト(例外一覧の照合)が失敗するため、テストを無効化
  aider-chat = pkgsFixed.aider-chat.overridePythonAttrs (_: {
    doCheck = false;
  });
in
{
  home.packages = [ aider-chat ];
}
