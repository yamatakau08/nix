{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.homeModules.home-shared
    ./emacs-pgtk.nix
    ./imagemagick.nix
    ./google-drive-ocamlfuse-service.nix
    ./android-studio.nix

    ./fuzzel.nix
    ./waybar/waybar.nix
    ./brightnessctl.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];
}
