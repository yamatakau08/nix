{ pkgs, lib, inputs, username, homeDirectory, isDarwin, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = lib.mkDefault username;
  home.homeDirectory = lib.mkDefault homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yama/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports =
    let
      commonModules = [ # for both Darwin and Linux
        ./fish.nix
        ./git.nix
        ./vim.nix
        ./wezterm.nix
        ./yt-dlp.nix
        ./ollama.nix
       ./zenn-cli.nix
      ];

      darwinModules = [
        inputs.mac-app-util.homeManagerModules.default

        ./emacs-gtk.nix
        ./mpv.nix
        ./qpdf.nix
        ./h2.nix
        ./imagemagick.nix
        ./exiftool.nix
        ./android-tools.nix
        ./scrcpy.nix
        ./anki-bin.nix
        ./gemini-cli.nix
        ./vlc-bin.nix # on Mac, use `-bin` package
        ./musescore.nix
        ./wireshark.nix
        ./gtypist.nix
        ./audacity.nix
        # ./python314.nix # manage with `nix develop`, not home-manager
        ./ffmpeg.nix
        ./nodejs_24.nix
        ./direnv.nix
        ./vhs.nix
        ./pythonPackage.grip.nix # GitHub Readme Instant Preview
        ./pythonPackage.pip.nix
        ./hunspell.nix
        ./wget.nix
        ./zoom-us.nix

        # the following unfree package
        ./appcleaner.nix
      ];

      linuxModules = [
        ./chromium.nix
        ./obsidian.nix
        ./google-drive-ocamlfuse.nix
        ./unzip.nix
        ./emacs-pgtk.nix
        ./waybar.nix
        ./fuzzel.nix
        ./brightnessctl.nix
        ./wireplumber.nix
        ./anki.nix
        ./hyprlock.nix
        ./hypridle.nix
        ./libnotify.nix
        ./mako.nix
        ./xdg-mime-apps.nix
      ];
    in
      commonModules
      ++ lib.optionals isDarwin darwinModules
      ++ lib.optionals (!isDarwin) linuxModules;

}
