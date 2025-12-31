{ config, pkgs, inputs, username, ... }:

{
  imports = [
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
