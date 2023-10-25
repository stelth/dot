{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    config,
    pkgs,
    final,
    ...
  }: {
    overlayAttrs = {
      inherit
        (config.packages)
        sessionizer
        switch-back-to-nvim
        sysdo
        tmux-cht
        ;

      vimPlugins = pkgs.vimPlugins // final.callPackage ../pkgs/vim-plugins {};
    };
  };
}
