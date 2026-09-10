{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    ## notonoto はソースビルドで fontTools 4.62+ と非互換のため、
    ## 使う場合は configuration.nix の ./overlays.nix (cmap-fix) を有効化する
    # notonoto
    # notonoto-hs

    hackgen-font                # テキスト用

    # the followins are for waybar icon
    nerd-fonts.symbols-only     # アイコン用: weather 領域(U+E3xx)等をカバー
    font-awesome                # アイコン用: 新しめ FA の6個(U+F590 等, Solid face)をカバー
  ];
}
