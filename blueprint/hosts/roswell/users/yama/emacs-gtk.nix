{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # emacs-gtk
    # (pkgs.emacs-gtk.override { withNativeCompilation = true; })
    cmigemo
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;

    # ネイティブコンパイルを有効にしたい場合:
    # package = pkgs.emacs-gtk.override { withNativeCompilation = true; };

    # extraConfig = ''
    #   (setq inhibit-startup-message t)
    # '';
  };
}
