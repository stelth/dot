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
  };

  xdg.mimeApps.enable = true;
}
