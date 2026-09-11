{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    android-tools
  ];
}
