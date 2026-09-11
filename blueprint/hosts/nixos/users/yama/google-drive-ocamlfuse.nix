{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    google-drive-ocamlfuse
  ];
}
