{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages = {
      sessionizer = pkgs.callPackage ./sessionizer {};
      switch-back-to-nvim = pkgs.callPackage ./switch-back-to-nvim {};
      sysdo = pkgs.callPackage ./sysdo {};
      tmux-cht = pkgs.callPackage ./tmux-cht {};
    };

    overlayAttrs = {
      inherit
        (config.packages)
        sessionizer
        switch-back-to-nvim
        sysdo
        tmux-cht
        ;
    };
  };
}
