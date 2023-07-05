{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-07-04";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "6deb3e7efcece6443d71f801c6a8b146d628a913";
      sha256 = "/dQjMsEr8lErGY2N6+nprOXsg1niS8OFZLhodHpPnwQ=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  }
