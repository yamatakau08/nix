{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-drive-ocamlfuse
  ];

  # Configuration for the systemd user service
  systemd.user.services.google-drive-mount = {
    Unit = {
      Description = "Google Drive Mount Service (google-drive-ocamlfuse)";
      After = [ "network-online.target" ];
      # If using sops-nix, uncomment the following line to ensure secrets are available before mounting
      # Requires = [ "sops-nix.service" ];
    };

    Service = {
      Type = "forking";
      # Create the mount point directory if it doesn't exist
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/gdrive";
      # Start the mount process. %h is a systemd specifier that expands to the user's home directory
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse %h/gdrive";
      # Unmount the drive when the service stops
      ExecStop = "/run/current-system/sw/bin/fusermount -u %h/gdrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    Install = {
      # Start this service when the user session starts
      WantedBy = [ "default.target" ];
    };
  };

}
