{...}: {
  imports = [
    ./1password.nix
    ./chat
    ./chrome.nix
    ./font.nix
    ./pavucontrol.nix
    ./playerctl.nix
  ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  xdg.mimeApps.enable = true;
}
