{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "v0.5.13";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-CLSbtSV5Bi2szzTaNQnBt0VGcmUTwv6HtQ3uidxtdV8=";
  };

  cargoHash = "sha256-dX9OrnZpbRazEvNog7boCQEvXnojBje/s7R3S+Gy6jc=";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
    platforms = platforms.all;
  };
}
