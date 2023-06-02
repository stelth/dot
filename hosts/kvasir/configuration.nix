{pkgs, ...}: {
  networking = {
    hostName = "kvasir";
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
