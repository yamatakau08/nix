{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.nixosModules.host-shared
    ./fonts.nix
    ./homebrew.nix
    ./overlays.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.yama.home = /Users/yama;

  # homebrew など、ユーザー単位で動作する機能が参照する。
  # 未設定だと homebrew.enable が assertion で失敗する。
  system.primaryUser = "yama";

  system.stateVersion = 6; # initial nix-darwin state

  # when execute `sudo darwin-rebuild switch --flake <flake.nix dir>/#roswell`,
  # the following error appears.
  # error: Determinate detected, aborting activation
  # Determinate uses its own daemon to manage the Nix installation that
  # conflicts with nix-darwin's native Nix management.
  # To turn off nix-darwin's management of the Nix installation, set:
  nix.enable = false;

  # Allow unfree packages
  # for appcleaner
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
}
