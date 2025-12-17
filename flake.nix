{
  description = "A basic Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Import the flake from ~/.config/nix/home-manager using a releative path
    user-home = {
      # url = "path:/Users/yama/.config/home-manager"; # pass
      # url = "path:./../home-manager"; # fail
      url = "path:./home-manager"; # pass need to copy home-manager under ~/.config/nix
      # Ensure the home-manager flake uses the same nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Import the flake from ~/.config/nix/nix-darwin
    user-darwin = {
      # url = "path:/Users/yama/.config/nix-darwin"; # pass
      # url = "path:./../nix-darwin"; # fail
      url = "path:./nix-darwin"; # pass need to copy nix-darwin under ~/.config/nix
      # Ensure the nix-darwin flake uses the same nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.home-manager.follows = "home-manager";
      inputs.mac-app-util.follows = "mac-app-util";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    # for NixOS
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { self, nixpkgs, user-home, user-darwin, home-manager, nix-darwin, mac-app-util, ... }@inputs: {
    # Re-export the home-manager configurations from your user-home flakes.
    inherit (user-home) homeConfigurations;

    # Re-export the nix-darwin configurations from your user-darwin flakes.
    inherit (user-darwin) darwinConfigurations;

    # Note: Use the original flakes directly for actual commands:
    # cd ~/.config/nix-darwin && darwin-rebuild switch --flake .#roswell
    # cd ~/.config/home-manager && home-manager switch --flake .

    nixosConfigurations = {
      tnt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
