{ config, pkgs, ... }:

{
  # for file manager to launch on Chrome file upload
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = [ "wlr" ];

    wlr.enable = true; # wlrootsconfigの設定
  };

  environment.sessionVariables = {
    WAYLAND_DISPLAY = "wayland-1";
    # XDG_SESSION_TYPE = "wayland";
  };
}
