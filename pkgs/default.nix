{pkgs ? import <nixpkgs> {}}: {
  neocmakelsp = pkgs.callPackage ./neocmakelsp {};
  switch-back-to-nvim = pkgs.callPackage ./switch-back-to-nvim {};
  tmux-cht = pkgs.callPackage ./tmux-cht {};
  tmux-sessionizer = pkgs.callPackage ./tmux-sessionizer {};
}
