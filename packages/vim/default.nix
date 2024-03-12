{pkgs}: {
  scope-vim = pkgs.callPackage ./scope-vim {};
  vimcomplete = pkgs.callPackage ./vimcomplete {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
