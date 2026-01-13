{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;

    taps = [
      "houmain/tap"
    ];

    brews = [
      "keymapper"
    ];

    casks = [
      "karabiner-elements"
    ];
  };
}
