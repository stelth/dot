{...}: {
  imports = [./apps-minimal.nix];
  homebrew = {
    casks = [
      "cyberduck"
      "discord"
      "firefox-developer-edition"
      "slack"
      "spotify"
    ];
    masApps = {};
  };
}
