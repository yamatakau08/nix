{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mas # Mac App Store command line interface
  ];
}
