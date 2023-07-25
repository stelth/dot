{pkgs}: {
  autosuggest-vim = pkgs.callPackage ./autosuggest-vim {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
