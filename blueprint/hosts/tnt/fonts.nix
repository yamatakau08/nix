{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    ## notonoto はソースビルドで fontTools 4.62+ と非互換のため、
    ## 使う場合は configuration.nix の ./overlays.nix (cmap-fix) を有効化する
    # notonoto
    # notonoto-hs

    hackgen-font
  ];
}
