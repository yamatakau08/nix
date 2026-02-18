{ pkgs, inputs, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
