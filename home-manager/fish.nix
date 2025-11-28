{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if type -q brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
      end

      if type -q direnv
         direnv hook fish | source
      end
    '';
  };

  # ~/.config/fish/functions ディレクトリ全体を管理
  #home.file.".config/fish/functions".source = ./.config/fish/functions;
}
