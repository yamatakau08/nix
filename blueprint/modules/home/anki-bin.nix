{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (anki-bin.withAddons [ pkgs.ankiAddons.anki-connect ])
  ];
}
