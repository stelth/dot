{ lib, pkgs, fetchFromGitHub, rustPlatform, }:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "d3c0ae4625accd7afec56f02aab68e1aca85699b";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-fEGRewzM41zGOVRmYNtr7f2wQ5qNdxUZUaZjSZ46C6g=";
  };

  cargoHash = "sha256-lACbnazrD+YO3ZUwiH6TZ/3GHWFpQ7AZiNqSI7ZocDQ=";

  nativeBuildInputs = with pkgs; [ cmake ];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [ maintainers.tailhook ];
  };
}
