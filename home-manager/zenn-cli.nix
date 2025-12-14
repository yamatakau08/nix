{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (zenn-cli.overrideAttrs (oldAttrs: rec {
      pname = "zenn-cli";
      version = "0.2.10";

      src = pkgs.fetchFromGitHub {
        owner = "zenn-dev";
        repo = "zenn-editor";
        rev = "zenn-cli@${version}";
        hash = "sha256-wItKDLAJHIyxUUaLIFM+sNYWtXKWC4P6GkCKn2Wh2JA=";
      };

      pnpmDeps = pkgs.pnpm_9.fetchDeps {
        inherit pname version src;
        hash = "sha256-WXsS5/J08n/dWV5MbyX4vK7j1mfiUoLdzwmzyqoX3FA=";
        fetcherVersion = 2;  # これを追加
      };
    }))
  ];
}
