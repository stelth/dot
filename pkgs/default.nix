self: super: {
  neocmakelsp = super.callPackage ./neocmakelsp { };
  switch-back-to-nvim = super.callPackage ./switch-back-to-nvim { };
  tmux-cht = super.callPackage ./tmux-cht { };
  tmux-sessionizer = super.callPackage ./tmux-sessionizer { };

  vimPlugins = super.vimPlugins // {
    fine-cmdline-nvim = super.callPackage ./vimPlugins/fine-cmdline-nvim { };
    leap-nvim = super.callPackage ./vimPlugins/leap-nvim { };
    nvim-surround = super.callPackage ./vimPlugins/nvim-surround { };
    staline-nvim = super.callPackage ./vimPlugins/staline-nvim { };
  };
}
