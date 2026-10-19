{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (hunspell.withDicts (dicts: with dicts; [ en_US ]))
  ];
}
