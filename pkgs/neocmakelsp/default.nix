{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-fGuXu7gWOnfEyp9H3i7K73L8YDmgmuLRJyXZAVDqCOw=";
  };

  cargoHash = "sha256-pVxfFR3/7d/lBq/oD0RLRb6Hr2AMLqNsX+FJTmANWvU=";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
