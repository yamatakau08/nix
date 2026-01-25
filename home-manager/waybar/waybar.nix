{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };

  xdg.configFile."waybar/power_menu.xml".source = ./power_menu.xml;
  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
}
