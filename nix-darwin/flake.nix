{
  description = "My nix-darwin system flake genereted by `nix flake init -t nix-darwin`";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      hostnames = {
        roswell = {
          username = "yama";
          hostPlatform = "aarch64-darwin";
        };
      };

      configuration = systemConfig: { pkgs, username, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [ pkgs.vim
          ];

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = systemConfig.hostPlatform;

        # when execute `sudo darwin-rebuild switch --flake ~/.config/nix-darwin#roswell`,
        # the following error appears.
        # error: Determinate detected, aborting activation
        # Determinate uses its own daemon to manage the Nix installation that
        # conflicts with nix-darwin’s native Nix management.
        # To turn off nix-darwin’s management of the Nix installation, set:
        nix.enable = false;
      };

      # Darwin設定を生成する関数
      mkDarwinConfiguration = hostname: systemConfig:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit (systemConfig) username;
          };
          modules = [
            (configuration systemConfig)
            ./fonts.nix
            ./fish.nix
            ./finder.nix
          ];
        };
  in
  {
    darwinConfigurations = builtins.mapAttrs mkDarwinConfiguration hostnames;
  };
}
