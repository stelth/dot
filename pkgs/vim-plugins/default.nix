{pkgs}: {
  lsp = pkgs.callPackage ./lsp {};
  vim-cmake = pkgs.callPackage ./vim-cmake {};
  vim-system-copy = pkgs.callPackage ./vim-system-copy {};
}
