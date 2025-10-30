{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gtypist
  ];
}
