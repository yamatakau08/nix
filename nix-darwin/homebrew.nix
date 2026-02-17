{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;

    taps = [
      # "houmain/tap" # for keymapper
    ];

    brews = [
      # "keymapper"
    ];

    casks = [
      "karabiner-elements"
    ];

    masApps = {
      ## Since mas (Mac App Store command line interface) can't find DiXiM Play U, comment the following
      # "DiXiM Play U" = 1576816161;
    };
  };
}
