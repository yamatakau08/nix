{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;

    settings = {
      pinentry-mode = "loopback";
    };
  };
}
