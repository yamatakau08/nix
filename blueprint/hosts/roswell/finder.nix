{ pkgs, username, ... }:

{
  system.primaryUser = username; # should be set system.primaryUser in case setting Finder

  system.defaults.finder = {
    AppleShowAllFiles = true;  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.AppleShowAllExtensions
    ShowPathbar = true;        # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowPathbar
  };
}
