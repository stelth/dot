{pkgs}: {
  autosuggest-vim = pkgs.callPackage ./autosuggest-vim {};
  vim9-lsp = pkgs.callPackage ./lsp {};
  vimcomplete = pkgs.callPackage ./vimcomplete {};
}
