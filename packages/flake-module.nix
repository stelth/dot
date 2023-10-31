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

      # vim plugins
      autosuggest-vim = pkgs.callPackage ./vim-plugins/autosuggest-vim {};
      rose-pine-vim = pkgs.callPackage ./vim-plugins/rose-pine-vim {};
      vim9-lsp = pkgs.callPackage ./vim-plugins/lsp {};
      vimcomplete = pkgs.callPackage ./vim-plugins/vimcomplete {};
      vsnip-complete-vim = pkgs.callPackage ./vim-plugins/vsnip-complete-vim {};
    };

    overlayAttrs = {
      inherit
        (config.packages)
        sessionizer
        switch-back-to-nvim
        sysdo
        tmux-cht
        # vim plugins
        
        autosuggest-vim
        rose-pine-vim
        vim9-lsp
        vimcomplete
        vsnip-complete-vim
        ;
    };
  };
}
