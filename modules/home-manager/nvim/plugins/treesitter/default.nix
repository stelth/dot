{ config, pkgs, lib, ... }: {
  home.packages = [ pkgs.tree-sitter ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin =
          nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
        file = ./treesitter.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-treesitter-textobjects;
        file = ./nvim-treesitter-textobjects.lua;
      })
      nvim-ts-context-commentstring
    ];
  };
}
