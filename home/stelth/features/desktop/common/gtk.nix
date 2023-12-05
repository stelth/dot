{pkgs, ...}: rec {
  gtk = {
    enable = true;
    font = {
      name = "Fira Code Nerd Font";
      size = 12;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Vimix";
      package = pkgs.vimix-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
