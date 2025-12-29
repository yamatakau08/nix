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

  outputs = inputs@{ nixpkgs, ... }:
    let
      username = "yama";
      platforms = [ "aarch64-darwin" "x86_64-linux" ];

      mkHome = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;  # Allow unfree packages
          };
          isDarwin = pkgs.stdenv.isDarwin;
          homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
        in
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through these arguments to home.nix
            extraSpecialArgs = {
              inherit inputs username homeDirectory isDarwin;
            };
          };
    in
      {
        # nix run home-manager/master --switch --flake <flake.nix directory>#username@platform [--dry-run]
        # home-manager switch --flake <flake.nix directory>#username@aarch64-darwin
        # home-manager switch --flake <flake.nix directory>#username@x86_64-linux
        homeConfigurations = builtins.listToAttrs (
          map (system: {
            name = "${username}@${system}";
            value = mkHome system;
          }) platforms
        );
      };
}
