{ config, pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-calc
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-cmp;
        file = ./cmp.lua;
      })
      friendly-snippets
      lspkind-nvim
      (config.lib.vimUtils.pluginWithCfg {
        plugin = luasnip;
        file = ./luasnip.lua;
      })
    ];
  };
}
