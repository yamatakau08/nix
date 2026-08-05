{ pkgs, inputs, ... }:
{

  imports = [
    inputs.self.homeModules.home-shared
    ./emacs-pgtk.nix
    ./imagemagick.nix
    ./google-drive-ocamlfuse-service.nix
  ];
}
