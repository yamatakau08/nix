{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # xremap.nix to download binary, don't use this flake.
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      # host configurations
      # ホスト名、ユーザー名、アーキテクチャをここで一括管理します
      hosts = {
        tnt = {
          username = "yama";
          platform = "x86_64-linux";
        };
      };

      # Home Manager のモジュール設定を生成する関数
      mkHomeManagerModule = host@{ username, platform, ... }:
        let
          pkgs = nixpkgs.legacyPackages.${platform};
          isDarwin = pkgs.stdenv.isDarwin;
          homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
        in
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs username homeDirectory isDarwin;
            mac-app-util = inputs.mac-app-util;
          };
          home-manager.users.${username} = {
            # home.nix 側で設定が重複しないよう、ここで基礎情報を上書き
            home.username = username;
            home.homeDirectory = pkgs.lib.mkForce homeDirectory;
            imports = [ ../home-manager/home.nix ];
          };
        };

      # NixOS システムを構築する関数
      mkNixosSystem = hostname: host@{ username, platform, ... }:
        nixpkgs.lib.nixosSystem {
          system = platform;
          specialArgs = {
            inherit inputs username hostname;
          };
          modules =
            nixpkgs.lib.optionals (hostname == "tnt") [
              ./hardware-configuration.nix
              ./configuration.nix
            ]
            ++ [
              # Home Manager の統合
              inputs.home-manager.nixosModules.home-manager

              # System-level feature configurations
              #./xremap.nix
              #./xremap-x11.nix
              ./xremap-niri.nix
              ./fish.nix
              ./hyprland.nix
              ./niri.nix
              ./xdg-desktop-portal-wlr.nix
              ./blueman.nix

              # ユーザー環境設定モジュールを適用
              (mkHomeManagerModule host)
            ];
        };
    in
    {
      # sudo nixos-rebuild switch --flake .#tnt
      nixosConfigurations = builtins.mapAttrs mkNixosSystem hosts;
    };
}
