{pkgs, ...}: ''
  {
    "coc.preferences.colorSupport": true,
    "coc.preferences.snippets.enable": true,
    "coc.preferences.useQuickFixForLocations": true,
    "codeLens.enable": true,
    "diagnostic.virtualText": true,
    "diagnostic.virtualTextCurrentLineOnly": false,
    "highlight.colors.enable": true,
    "inlayHint.enable": true,
    "inlayHint.enableParameter": true,
    "signature.enable": true,
    "suggest.removeDuplicateItems": true,
    "suggest.noselect": true,

    "clangd.path": "${pkgs.clang-tools}/bin/clangd"
  }
''
