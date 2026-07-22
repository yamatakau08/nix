{ config, pkgs, ... }:

{
  programs.yt-dlp = {
    enable = true;
    settings = {
      # ここに yt-dlp の設定を記述できます (例: テンプレートなど)
      # format = "mp4";
      # output = "%(title)s-%(id)s.%(ext)s";
      output =   "%(title)s.%(ext)s";
    };
    extraConfig = ''
       -f b[ext=mp4]
     '';
  };
}
