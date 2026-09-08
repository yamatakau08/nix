{pkgs, ...}: 

let
  firmwareSrc = builtins.fetchGit {
    url = "file:///home/yama/t2-firmware";
    rev = "978d9afe07519cc62f85b23d661800779c76981e";  # rev = `git -C ~/t2-firmware rev-parse HEAD`
  };
in
{
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = "${firmwareSrc}/firmware.tar";

      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];

  # Enable the bluetoothd daemon (required for bluetoothctl/BlueZ to work,
  # independent of firmware being loaded correctly).
  hardware.bluetooth.enable = true;
}
