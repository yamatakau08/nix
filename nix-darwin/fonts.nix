{ pkgs, ... }:

# {
#   fonts.packages = with pkgs; [
#     notonoto
#     # notonoto-hs
#   ];
# }

# notonoto, notonoto-hs の両方に fontTools の依存を追加するオーバーレイ
let
  add-fonttools-overlay = self: super: {
    # ... (notonoto-hs と notonoto の overrideAttrs の定義はそのまま) ...
    notonoto-hs = super.notonoto-hs.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [ super.python3Packages.fonttools ];
    });

    notonoto = super.notonoto.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [ super.python3Packages.fonttools ];
    });
  };

  # 修正点: pkgs.applyOverlays の代わりに、より広く互換性のある関数を使う
  # ここで、以前使っていた pkgs.appendOverlays に戻します。
  # もし pkgs.appendOverlays も動作しない場合、lib.applyOverlays を試します。
  pkgs-fixed = pkgs.appendOverlays [ add-fonttools-overlay ];

in
{
  # 修正された pkgs-fixed を使用してフォントを定義
  fonts.packages = with pkgs-fixed; [
    notonoto
    notonoto-hs
  ];
}
