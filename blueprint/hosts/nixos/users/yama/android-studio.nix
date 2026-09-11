{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    android-studio
  ];

  home.sessionVariables = {
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
  };

}
