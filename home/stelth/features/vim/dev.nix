{pkgs, ...}: {
  home.packages = with pkgs; [cmake];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      friendly-snippets
      vim-cmake
      vim-commentary
      vim-endwise
      vim-polyglot
      vim-vsnip
      vim-vsnip-integ
    ];
  };
}
