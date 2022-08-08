self: super: {
  neocmakelsp = super.callPackage ./neocmakelsp { };
  switch-back-to-nvim = super.callPackage ./switch-back-to-nvim { };
  tmux-cht = super.callPackage ./tmux-cht { };
  tmux-sessionizer = super.callPackage ./tmux-sessionizer { };
}
