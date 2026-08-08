{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.homeModules.home-shared
    inputs.mac-app-util.homeManagerModules.default
    inputs.nix-index-database.homeModules.default # for comma

    ./appcleaner.nix

    ./emacs-gtk.nix
    ./imagemagick.nix # for emacs image-dired

    ./android-tools.nix
    ./anki-bin.nix
    ./vlc-bin.nix
    ./audacity.nix
    ./direnv.nix
    # ./claude-code.nix
    # ./freetube.nix # due to build error (macOS codesign, upstream unresolved)

    ./karabiner-elements.nix

    ./duckdb.nix
    ./dbeaver-bin.nix
  ];

  programs.nix-index-database.comma.enable = true; # for comma
}
