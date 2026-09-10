{ inputs, flake, ... }:
{
  class = "nixos";

  # value = inputs.nixpkgs.lib.nixosSystem { # system packages unstable
  #   system = "x86_64-linux";
  #   specialArgs = { inherit inputs flake; };
  #   modules = [
  #     ./configuration.nix
  #     inputs.nixos-hardware.nixosModules.apple-t2
  #     inputs.home-manager.nixosModules.home-manager # home-manager: unstable
  #     {
  #       home-manager.useGlobalPkgs = true;
  #       home-manager.useUserPackages = true;
  #       home-manager.users.yama = import ./users/yama/home-configuration.nix;
  #       home-manager.extraSpecialArgs = { inherit inputs; };
  #     }
  #   ];
  # };

  value = inputs.nixpkgs-25_11.lib.nixosSystem { # system packages 25.11
    system = "x86_64-linux";
    specialArgs = { inherit inputs flake; };
    modules = [
      ./configuration.nix
      inputs.nixos-hardware.nixosModules.apple-t2
      inputs.home-manager-25_11.nixosModules.home-manager # home-manager packages 25.11
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.yama = import ./users/yama/home-configuration.nix;
        home-manager.extraSpecialArgs = { inherit inputs; };
      }
    ];
  };
}
