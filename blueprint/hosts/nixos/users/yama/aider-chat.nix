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
in
{
  home.packages = [
    pkgsFixed.aider-chat
  ];
}
