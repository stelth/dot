{pkgs, ...}: {
  home.packages = with pkgs; [cmake];

  programs.vim = {
    plugins = with pkgs.vimExtraPlugins; [
      vim-cmake
      vim-commentary
      vim-endwise
      vim-polyglot
      vim-snippets
    ];
  };
}
