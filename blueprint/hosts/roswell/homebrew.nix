{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      # "houmain/tap" # for keymapper
    ];

    brews = [
      # "keymapper"
    ];

    casks = [
      "hammerspoon"
      # "karabiner-elements"
      ## Claude Desktop is registered with auto_update: true
      ## Since upgrade is skipped, add greedy = true;
      { name = "claude"; greedy = true;} # Desktop
    ];

    masApps = {
      ## Since LINE install failed, comment the following
      # "LINE" = 539883307;
      ## Since mas (Mac App Store command line interface) can't find DiXiM Play U, comment the following
      # "DiXiM Play U" = 1576816161;
    };
  };
}
