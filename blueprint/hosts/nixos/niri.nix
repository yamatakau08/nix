{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
  };

  # Fix: Chrome file upload dialog does not appear.
  # Niri's default gnome portal needs Nautilus for FileChooser, so add the gtk portal.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [ "gtk" ];
      # enable this (overrides Niri's own portal config)
      niri."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

}
