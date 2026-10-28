{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test "$(uname -s)" = "Darwin"
        if test "$(uname -m)" = "arm64"
          eval "$(/opt/homebrew/bin/brew shellenv)"
          fish_add_path --path --append --move /opt/homebrew/bin /opt/homebrew/sbin
        else
          eval "$(/usr/local/bin/brew shellenv)" # x86_64 intel Mac
          fish_add_path --path --append --move /usr/local/bin /usr/local/sbin
        end
      end

      if type -q direnv
         direnv hook fish | source
      end

      set --export LESSEDIT "vi %f"
      set --export OLLAMA_API_BASE http://127.0.0.1:11434
    '';

    shellAliases = {
      less = "less --RAW-CONTROL-CHARS";
    };
  };

  # ~/.config/fish/functions ディレクトリ全体を管理
  #home.file.".config/fish/functions".source = ./.config/fish/functions;
}
