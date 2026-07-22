{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    # settings = {
    #   # ここに wezterm の設定を記述できます
    #   font_size = 11;
    #   default_cursor_style = "Beam";
    # };
  };
}
