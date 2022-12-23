{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "0.4.9";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-5iQcHrFmVUieEAPyrRVYUmllmN4LJ99ta1qaIMfc23Q";
  };

  cargoHash = "sha256-aorfVnDFWeER+7k1YnzqBwhLt6SNSVD2Sfs3tu02RyI";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
