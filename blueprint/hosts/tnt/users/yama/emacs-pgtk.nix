{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cmigemo
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    ## enable Emacs builtin ImageMagick function
    ## the following configuration has assert!
    # package = pkgs.emacs-pgtk.override { withImageMagick = true; };

    # extraConfig = ''
    #   (setq inhibit-startup-message t)
    # '';
  };
}
