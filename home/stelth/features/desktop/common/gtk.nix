{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in rec {
  gtk = {
    enable = true;
    font = {
      name = "Fira Code Nerd Font";
      size = 12;
    };
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme {scheme = config.colorScheme;};
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
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
