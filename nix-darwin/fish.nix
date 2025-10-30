{ pkgs, username, ... }:
{
  # Fish shell configuration
  programs.fish = {
    enable = true;

    # システム全体の設定（全ユーザーに適用される）
    # shellInit = ''
    #   # システム全体で必要な設定のみここに記述
    # '';
  };

  # システムパッケージにFishを追加
  environment.systemPackages = with pkgs; [
    fish
  ];

  # ユーザー設定
  users.users."${username}" = {
    shell = pkgs.fish;  # ログインシェルをFishに設定（必須）
  };

  # ユーザー固有のFish設定は home-manager で行う：
  #
  # home-manager での設定例：
  # programs.fish = {
  #   enable = true;
  #   shellInit = ''
  #     set -g fish_greeting ""
  #   '';
  #   functions = {
  #     ll = "ls -la";
  #   };
  # };
  #
  # 注意: Nix Darwin の users.users.${username}.shell と
  #       home-manager の programs.fish.enable は両方とも必要
  #       - Nix Darwin: ログインシェルの指定
  #       - home-manager: Fish設定ファイルの管理
}
