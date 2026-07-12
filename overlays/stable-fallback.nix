# unstable で壊れている(= Hydra が落ちていてバイナリキャッシュが無い)パッケージを stable に逃がす overlay。
# unstable 側が直ったら該当行を消すだけでよい。
#
# 注意: ここに書くのはアプリ(leaf)だけにすること。ffmpeg のようなライブラリを差し替えると
#       unstable 側の依存元が全部リビルドになり、キャッシュが効かなくなって本末転倒になる。
{ inputs }:

final: prev:

let
  stable = import inputs.nixpkgs-stable {
    inherit (prev.stdenv.hostPlatform) system;
    # unstable の config をそのまま渡すと stable 側に無いオプションで弾かれるため、必要なものだけ渡す
    config.allowUnfree = prev.config.allowUnfree or false;
  };
in
{
  # mpv: unstable の darwin ビルドが cctools の ld の SIGTRAP で落ちる。
  #   https://github.com/NixOS/nixpkgs/issues/540682 (修正 PR #540762 は未マージ)
  # stable も同じ 0.41.0 で、しかもビルド済みがキャッシュにある。
  # PR がマージされて unstable に入ったら、この行を消す。
  inherit (stable) mpv mpv-unwrapped;
  inherit (stable) musescore;
  inherit (stable) audacity;
  inherit (stable) colima; # for docker
}
