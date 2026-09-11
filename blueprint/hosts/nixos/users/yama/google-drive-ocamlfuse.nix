{ config, pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs {
    system = pkgs.system;
  };
in
{
  home.packages = with pkgs; [
    pkgs-unstable.google-drive-ocamlfuse
  ];
}
