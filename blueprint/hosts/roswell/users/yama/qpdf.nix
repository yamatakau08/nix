{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    qpdf
  ];

#  this can't install qpdf, shoud use the above.
#  programs.qpdf = {
#    enable = true;
#  };
}
