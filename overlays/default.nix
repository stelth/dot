{withSystem, ...}: {
  flake.overlays = {
    localPackages = final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        {config, ...}: {
          inherit
            (config.packages)
            sessionizer
            switch-back-to-nvim
            sysdo
            tmux-cht
            ;
        }
      );
    vimPlugins = final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        {config, ...}: {
          inherit
            (config.packages)
            autosuggest-vim
            rose-pine-vim
            vim9-lsp
            vimcomplete
            vsnip-complete-vim
            ;
        }
      );
  };
}
