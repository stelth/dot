self: super: {
  neocmakelsp = super.callPackage ./neocmakelsp { };
  switch-back-to-nvim = super.callPackage ./switch-back-to-nvim { };
  tmux-cht = super.callPackage ./tmux-cht { };
  tmux-sessionizer = super.callPackage ./tmux-sessionizer { };

  vimPlugins = super.vimPlugins // {
    fine-cmdline-nvim = super.callPackage ./vimPlugins/fine-cmdline-nvim {
      inherit (super) pkgs;
    };
    leap-nvim =
      super.callPackage ./vimPlugins/leap-nvim { inherit (super) pkgs; };
    nvim-surround =
      super.callPackage ./vimPlugins/nvim-surround { inherit (super) pkgs; };
    staline-nvim =
      super.callPackage ./vimPlugins/staline-nvim { inherit (super) pkgs; };
  };
}
