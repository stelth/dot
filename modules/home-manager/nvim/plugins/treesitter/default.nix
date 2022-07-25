{ config, pkgs, lib, ... }: {
  home.packages = [ pkgs.tree-sitter ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (config.lib.vimUtils.pluginWithCfg {
        plugin =
          nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
        file = ./treesitter.lua;
      })
      nvim-ts-context-commentstring
    ];
  };
}
