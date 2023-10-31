{pkgs}: {
  autosuggest-vim = pkgs.callPackage ./autosuggest-vim {};
  rose-pine-vim = pkgs.callPackage ./rose-pine-vim {};
  vim9-lsp = pkgs.callPackage ./lsp {};
  vimcomplete = pkgs.callPackage ./vimcomplete {};
  vsnip-complete-vim = pkgs.callPackage ./vsnip-complete-vim {};
}
