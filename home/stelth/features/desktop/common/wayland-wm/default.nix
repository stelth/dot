{pkgs, ...}: {
  imports = [
    ./mako.nix
    ./runner
    ./swaylock.nix
    ./waybar
    ./wlogout
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
