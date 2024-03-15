{
  vimUtils,
  fetchFromGitHub,
}: let
  pname = "vim9-lsp";
  version = "2024-03-15";
in
  vimUtils.buildVimPlugin {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "f5adbd10cf2fc486c5101a61ed45489a0f6b8c40";
      sha256 = "sha256-2sGj6DF1nEzDERBxbBmeeDLJwhKhKlMWOha6AfNVb3k=";
    };

    meta.homepage = "https://www.github.com/yegappan/lsp";
  }
