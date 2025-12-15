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
      pkgs = nixpkgs.legacyPackages.${system};

      isDarwin = pkgs.stdenv.isDarwin;

      username = "yama";
      homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Optionally use extraSpecialArgs
        # to pass through these arguments to home.nix
        extraSpecialArgs = {
          inherit username homeDirectory;
          inherit isDarwin;
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ]
                  ++ ( if isDarwin then [ mac-app-util.homeManagerModules.default ] else []);
      };
    };
}
