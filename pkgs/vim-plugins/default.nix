{pkgs}: {
  vim-cmake = pkgs.callPackage ./vim-cmake {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
