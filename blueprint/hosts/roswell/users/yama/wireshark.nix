{ config, pkgs, ... }:

#let
#  # 1. 目的のWiresharkパッケージが含まれるNixpkgsリビジョンをピン留めします。
#  #
#  # ユーザーが指定したビルドに対応するNixpkgsの正確なコミットハッシュ (rev) が必要です。
#  # 以下の YOUR_SPECIFIC_COMMIT_HASH と SHA256_HASH_OF_TARBALL を、
#  # 目的のHydraビルドに対応する正しい値に置き換えてください。
#  # 正しいハッシュを使用しない場合、Nixはダウンロードを拒否します。
#  #
#  # (注意: 代替案として、最新のunstableブランチを使用する場合は以下のコメントアウトされた例を参照してください)
#  # unstablePin = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
#
#  nixpkgs_pin = builtins.fetchTarball {
#    # 目的のコミットハッシュに置き換えてください
#    url = "https://github.com/NixOS/nixpkgs/archive/YOUR_SPECIFIC_COMMIT_HASH.tar.gz";
#
#    # WARNING: このSHA256ハッシュは仮の値です。上記のCOMMIT_HASHに対応する
#    # 正しいハッシュに必ず置き換えてください。
#    sha256 = "0000000000000000000000000000000000000000000000000000";
#  };
#
#  # 2. ピン留めしたNixpkgsをインポートし、パッケージセットを取得します。
#  #    Wiresharkは「unfree」パッケージであるため、インストールを許可するように設定を渡します。
#  pinnedPkgs = import nixpkgs_pin {
#    config = {
#      allowUnfree = true;
#    };
#  };
#in
{
  home.packages = with pkgs; [
    wireshark
  ];
}
