{ inputs, ... }:

{
  nixpkgs.overlays = [
    (import ./overlays/notonoto-cmap-fix.nix)
    (import ./overlays/stable-fallback.nix { inherit inputs; })
  ];
}
