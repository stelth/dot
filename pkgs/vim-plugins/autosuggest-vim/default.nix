{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "autosuggest-vim";
in
  vimUtils.buildVimPlugin {
    inherit pname;
    version = "2023-08-11";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "680e18f59fe49d3c3e7d8092e0d6b41f9a7bfb71";
      sha256 = "OtMFCUVSTWikKa33R7IlI58wajDURelW6r3szXhvLb0=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  }
