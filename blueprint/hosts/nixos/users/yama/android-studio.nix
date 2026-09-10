{ config, pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
    pkgs-unstable.android-studio
  ];

  home.sessionVariables = {
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
  };

}
