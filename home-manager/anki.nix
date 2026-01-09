{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (anki.withAddons [ pkgs.ankiAddons.anki-connect ])
  ];
}
