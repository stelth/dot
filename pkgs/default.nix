{pkgs ? import <nixpkgs> {}}: {
  neocmakelsp = pkgs.callPackage ./neocmakelsp {};
  sessionizer = pkgs.callPackage ./sessionizer {};
  switch-back-to-nvim = pkgs.callPackage ./switch-back-to-nvim {};
  sysdo = pkgs.callPackage ./sysdo {};
  tmux-cht = pkgs.callPackage ./tmux-cht {};
}
