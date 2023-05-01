{...}: {
  programs.google-chrome-beta = {
    enable = true;
  };

  home = {
    sessionVariables.BROWSER = "google-chrome-beta";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["google-chrome.desktop"];
    "text/xml" = ["google-chrome.desktop"];
    "x-scheme-handler/http" = ["google-chrome.desktop"];
    "x-scheme-handler/https" = ["google-chrome.desktop"];
  };
}
