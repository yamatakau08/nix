{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "x-scheme-handler/http"    = ["chromium-browser.desktop" "firefox.desktop"];
      "x-scheme-handler/https"   = ["chromium-browser.desktop" "firefox.desktop"];
      "text/html"                = ["chromium-browser.desktop" "firefox.desktop"];
      "x-scheme-handler/about"   = ["chromium-browser.desktop" "firefox.desktop"];
      "x-scheme-handler/unknown" = ["chromium-browser.desktop" "firefox.desktop"];
    };
  };
}
