{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      notonoto-hs
      noto-fonts-cjk-sans
      # noto-fonts-color-emoji # comment default installed
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "NOTONOTO HS"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Serif CJK JP"
        ];
        monospace = [
          "NOTONOTO HS"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
