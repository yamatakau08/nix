{ inputs, lib, pkgs, ... }:
let
  p25 = inputs.nixpkgs-25_11.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  t2 = "${inputs.nixos-hardware}/apple/t2/pkgs/linux-t2";
  kernel0 = p25.callPackage "${t2}/generic.nix" { } {
    kernel = p25.linux_6_18;
    patchesFile = "${t2}/stable.json";
  };
  # unstable のモジュールが期待する属性を補う
  kernel = kernel0.overrideAttrs (old: {
    passthru = (old.passthru or { }) // {
      target = "bzImage";
      buildDTBs = false;
    };
  });
in
{
  boot.kernelPackages = lib.mkForce (p25.linuxPackagesFor kernel);
}
