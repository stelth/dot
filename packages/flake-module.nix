{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    config,
    final,
    pkgs,
    ...
  }: {
    packages = {
      gersemi = pkgs.callPackage ./gersemi {};
      sessionizer = pkgs.callPackage ./sessionizer {};
      switch-back-to-nvim = pkgs.callPackage ./switch-back-to-nvim {};
      sysdo = pkgs.callPackage ./sysdo {};
      tmux-cht = pkgs.callPackage ./tmux-cht {};
    };

    overlayAttrs = {
      inherit
        (config.packages)
        gersemi
        sessionizer
        switch-back-to-nvim
        sysdo
        tmux-cht
        ;

      vimPlugins = pkgs.vimPlugins // final.callPackage ./vim {};
    };

    apps = {
      sysdo.program = "${config.packages.sysdo}/bin/sysdo";
    };
  };
}
