{...}: {
  programs.google-chrome = {
    enable = true;
  };

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/google-chrome"
      ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["google-chrome.desktop"];
    "text/xml" = ["google-chrome.desktop"];
    "x-scheme-handler/http" = ["google-chrome.desktop"];
    "x-scheme-handler/https" = ["google-chrome.desktop"];
  };
}
