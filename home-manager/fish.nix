{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test "$(uname -s)" = "Darwin"
        if test "$(uname -m)" = "arm64"
          eval "$(/opt/homebrew/bin/brew shellenv)"
        else
          eval "$(/usr/local/bin/brew shellenv)" # x86_64 intel Mac
        end
      end

      if type -q direnv
         direnv hook fish | source
      end
    '';

    shellAliases = {
      less = "less --RAW-CONTROL-CHARS";
    };
  };

  # ~/.config/fish/functions ディレクトリ全体を管理
  #home.file.".config/fish/functions".source = ./.config/fish/functions;
}
