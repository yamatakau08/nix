{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.homeModules.home-shared
    inputs.mac-app-util.homeManagerModules.default

    ./appcleaner.nix

    ./emacs-gtk.nix
    ./android-tools.nix
    ./anki-bin.nix
    ./vlc-bin.nix
    # ./audacity.nix
    ./direnv.nix
    # ./claude-code.nix
  ];
}
