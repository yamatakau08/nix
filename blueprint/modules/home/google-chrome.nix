{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome # for aarch64-darwin, x86_64-linux
  ];
}
