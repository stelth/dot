{pkgs}: {
  vimcomplete = pkgs.callPackage ./vimcomplete {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
