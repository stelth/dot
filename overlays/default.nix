{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem = {
    config,
    pkgs,
    final,
    system,
    ...
  }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      overlays = [
        inputs.nur.overlay
      ];
    };

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
