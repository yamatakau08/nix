{ config, pkgs, lib, ... }:

let
  xremap-x11-bin = pkgs.stdenv.mkDerivation {
    pname = "xremap-x11";
    version = "0.14.8";

    src = pkgs.fetchzip {
      url = "https://github.com/xremap/xremap/releases/download/v0.14.8/xremap-linux-x86_64-x11.zip";
      sha256 = "sha256-oZpmlsJ+ALhg4o49QicvnxhgBd2jBqqmiq9rU71aYG4=";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp xremap $out/bin/
      chmod +x $out/bin/xremap
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    xremap-x11-bin
    xorg.xhost # for 'xhost +SI:localuser:root'
  ];
}
