{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    notonoto
    notonoto-hs
  ];
}
