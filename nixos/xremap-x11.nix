{ pkgs, inputs, username, ... }:

{
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  services.xremap = {
    enable = true;
    withX11 = true;
    userName = username;
    serviceMode = "user";

    yamlConfig = builtins.readFile ./xremap-config.yml;
  };

}
