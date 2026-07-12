{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../overlays/notonoto-cmap-fix.nix) ];

  fonts.packages = with pkgs; [
    notonoto
    notonoto-hs
  ];
}
