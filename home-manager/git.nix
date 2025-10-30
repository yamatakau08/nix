{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      core = {
        editor = "vi";
      };
      user = {
        email = "yamatakau08@gmail.com";
        name = "yamatakau08";
      };
    };

    ignores = [ ".DS_Store" ];
  };
}
