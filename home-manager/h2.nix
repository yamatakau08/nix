{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    h2
  ];
}
