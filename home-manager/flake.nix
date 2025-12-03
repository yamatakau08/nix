{
  description = "Home Manager configuration of yama";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    { nixpkgs, home-manager, mac-app-util, ... }:
    let
      system = "aarch64-darwin";
      username = "yama";
      homeDirectory = "/Users/${username}";

      # pkgs = nixpkgs.legacyPackages.${system}; # this is included by the following `inherit system;`
      # for unfree pacakges
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "appcleaner"
              # "claude-code"
            ];
        };
      };
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Optionally use extraSpecialArgs
        # to pass through these arguments to home.nix
        extraSpecialArgs = {
          inherit username homeDirectory;
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          mac-app-util.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
