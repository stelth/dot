{pkgs}: {
  easyjump-vim = pkgs.callPackage ./easyjump-vim {};
  fFtT-vim = pkgs.callPackage ./fFtT-vim {};
  scope-vim = pkgs.callPackage ./scope-vim {};
  vimcomplete = pkgs.callPackage ./vimcomplete {};
  vim9-lsp = pkgs.callPackage ./lsp {};
}
