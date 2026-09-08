{ inputs, flake, ... }:
{
  class = "nixos";

  value = inputs.nixpkgs-25_11.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs flake; };
    modules = [
      ./configuration.nix
      inputs.home-manager-25_11.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.yama = import ./users/yama/home-configuration.nix;
        home-manager.extraSpecialArgs = { inherit inputs; };
      }
    ];
  };
}
