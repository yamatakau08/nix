{ pkgs,  ... }:

{
  environment.systemPackages = with pkgs; [
    autoconf
  ];
}
