{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;

    package = pkgs.direnv.overrideAttrs (oldAttrs: {
      env = builtins.removeAttrs (oldAttrs.env or { }) [ "CGO_ENABLED" ];

      postPatch = (oldAttrs.postPatch or "") + ''
        sed -i '/ifeq ($(shell uname), Darwin)/,/^endif/{/linkmode=external/d}' GNUmakefile
      '';

      doCheck = false;
    });
  };
}
