{ config, pkgs, inputs, username, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  services.xremap = {
    enable = true;
    userName = "${username}";
    config = {
      modmap = [
        {
          name = "CapsLock to Ctrl";
          remap = {
            CapsLock = "Ctrl_L";
          };
        }
      ];
      keymap = [
        {
          name = "ZenkakuHankaku to Esc";
          remap = {
            Grave = "Esc";
          };
        }
      ];
    };
  };
}
