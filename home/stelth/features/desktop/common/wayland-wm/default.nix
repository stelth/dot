{pkgs, ...}: {
  imports = [
    ./foot
    ./mako.nix
    ./swaylock.nix
    ./waybar
    ./wlogout
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    grim
    imv
    mimeo
    pulseaudio
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };
}
