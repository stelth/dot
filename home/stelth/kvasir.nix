{inputs, ...}: let
  inherit (inputs.nix-colors.colorSchemes) onedark;
in {
  imports = [
    ./global
    ./features/cli
    ./features/vim
    ./features/desktop/sway
  ];

  colorscheme = onedark;

  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      workspace = "1";
    }
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      workspace = "2";
      x = 1920;
    }
  ];
}
