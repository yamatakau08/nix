{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (hunspellWithDicts [ hunspellDicts.en-us ])
  ];
}
