{pkgs, ...}: {
  home.packages = with pkgs; [cmake];

  programs.vim = {
    plugins = with pkgs.vimExtraPlugins; [
      {
        plugin = vim-cmake;
        config = ''
          " vim-cmake {{{
          let g:cmake_link_compile_commands = 1
          " }}}
        '';
      }
      vim-commentary
      vim-endwise
      vim-polyglot
      vim-snippets
    ];
  };
}
