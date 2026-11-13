{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-screenrec
  ];
}
