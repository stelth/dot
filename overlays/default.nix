{withSystem, ...}: {
  flake.overlays.additions = final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      {config, ...}: {
        inherit
          (config.packages)
          sessionizer
          switch-back-to-nvim
          sysdo
          tmux-cht
          ;
        vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {};
      }
    );
}
