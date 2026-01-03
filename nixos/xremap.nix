{ config, pkgs, lib, username, ... }:

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

  xremapConfig = ./xremap-config.yml;
in
{
  environment.systemPackages = with pkgs; [
    xremap-x11-bin
    xorg.xhost # for 'xhost +SI:localuser:root'
  ];

  systemd.user.services.xhost-root = {
    description = "Allow root access to X11 for xremap";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:root";
      RemainAfterExit = true;
    };
  };

  systemd.services.xremap = {
    description = "xremap key remapper";
    wantedBy = [ "multi-user.target" ];
    after = [ "display-manager.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${xremap-x11-bin}/bin/xremap ${xremapConfig} --watch";
      Restart = "always";
      RestartSec = 1;
    };
    environment = {
      DISPLAY = ":0";
      # XAUTHORITY = "/home/${username}/.Xauthority";
    };
  };

}
