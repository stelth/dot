{pkgs, ...}: rec {
  gtk = {
    enable = true;
    font = {
      name = "Fira Code Nerd Font";
      size = 12;
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-gtk;
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
