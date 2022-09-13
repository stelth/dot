{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "2121eb2038c27370e8bfcc7e717b876901143877";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-svqkdrjp3+hGXkR/DoVWPw4lR6HNC6N8/SZwI+0jPg0=";
  };

  cargoHash = "sha256-ZZMsuJQQXpAWjn8eV94z9xC5z3W6bjG+lfHKyUCReTU=";

  cargoPatches = [./cargo-lock.patch];

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
