{ config, pkgs, lib, ... }: {
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      clangd_extensions-nvim
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      comment-nvim
      dressing-nvim
      friendly-snippets
      git-worktree-nvim
      harpoon
      lspkind-nvim
      lsp_signature-nvim
      lua-dev-nvim
      luasnip
      neogit
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-jdtls
      nvim-lspconfig
      nvim-notify
      nvim-ts-context-commentstring
      plenary-nvim
      telescope-dap-nvim
      telescope-nvim
      tokyonight-nvim
      undotree
      vim-matchup
    ];

    extraPackages = with pkgs; [
      # Essentials
      tree-sitter
      fd

      # C/C++
      clang-tools_14
      cppcheck
      lldb_14

      # Java
      jdt-language-server

      #nix
      nixfmt
      rnix-lsp
      statix

      # python
      (python3.withPackages
        (ps: with ps; [ autopep8 debugpy flake8 isort yamllint ]))
      nodePackages.pyright

      # Lua
      selene
      stylua
      sumneko-lua-language-server

      # Shell scripting
      nodePackages.bash-language-server
      shellcheck
      shellharden
      shfmt

      # Additional
      cmake-language-server
      nodePackages.markdownlint-cli
      nodePackages.prettier
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
    ];
  };
}
