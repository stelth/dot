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

    extraConfig = ''
      " vim-cmake {{{
      let g:cmake_link_compile_commands = 1
      " }}}
    '';
  };
}
