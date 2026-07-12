# NOTONOTO v0.0.3 の fonttools_script.py は「pyftmerge が cmap format 14
# (異体字シーケンス) を落とす」前提で、マージ後に手動で format 14 を追加する。
# fontTools 4.58.1 以降は pyftmerge 自体が format 14 を生成するため重複になり、
# 4.62.0 以降はその重複がコンパイル時エラーになってビルドが失敗する。
# 手動追加 (fix_cmap_table) の呼び出しを無効化する。
final: prev:
let
  fixCmap =
    pkg:
    pkg.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace fonttools_script.py \
          --replace-fail 'fix_cmap_table(xml, style, variant)' \
                         'pass  # cmap_format_14 is emitted by pyftmerge (fontTools >= 4.58.1)'
      '';
    });
in
{
  notonoto = fixCmap prev.notonoto;
  notonoto-hs = fixCmap prev.notonoto-hs;
}
