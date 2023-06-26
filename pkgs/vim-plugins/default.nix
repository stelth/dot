{pkgs}: {
  search-complete-vim = pkgs.callPackage ./search-complete {};
  vim-cmake = pkgs.callPackage ./vim-cmake {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
