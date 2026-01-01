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
        {
          name = "Emacs Binding";
          application = {
            # Nixのリスト形式で記述
            not = [ "Emacs" "org.wezfurlong.wezterm" ];
          };
          remap = {
            "C-p" = "up";
            "C-n" = "down";
            "C-a" = "home";
            "C-e" = "end";
            "C-d" = "delete";
          };
        }
      ];
    };
  };
}
