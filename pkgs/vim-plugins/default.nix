{pkgs}: {
  search-complete-vim = pkgs.callPackage ./search-complete {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
