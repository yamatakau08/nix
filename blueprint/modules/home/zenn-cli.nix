{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (zenn-cli.overrideAttrs (oldAttrs: rec {
      pname = "zenn-cli";
      version = "0.5.2";

      src = pkgs.fetchFromGitHub {
        owner = "zenn-dev";
        repo = "zenn-editor";
        rev = "v${version}";
        hash = "sha256-zvQ8b7ZaDBYGMGqOcttixjaQpC27vtvZ6ZXpzmg9Sf4=";
      };

      pnpmDeps = pkgs.pnpm_10.fetchDeps {
        inherit pname version src;
        hash = "sha256-tPA2pgbvcFIL3UXr+G6XLdmdTxzdx6pi6KnzvvkCYAk=";
        fetcherVersion = 3;
      };
    }))
  ];
}
