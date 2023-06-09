{pkgs, ...}: {
  home.packages = with pkgs; [cmake ninja];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim-cmake
      vim-commentary
      vim-endwise
      vim-polyglot
      vim-snippets
      vim-vsnip
      vim-vsnip-integ
    ];
  };
}
