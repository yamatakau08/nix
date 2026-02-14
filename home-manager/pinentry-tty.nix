{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry-tty
  ];
}
