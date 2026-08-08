{ ... }:

{
  nixpkgs.overlays = [
    (import ./overlays/notonoto-cmap-fix.nix)
  ];
}
