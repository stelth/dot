{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "41dcc7621c408a1038456c4adadde721aef9cb33";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-SLXROXfysRlZ0sjq38v51IrNzzGu4rhnaWiFi8XlWgE=";
  };

  cargoHash = "sha256-eIx04EKOddy8qeMa43sfOThncPzgrlN/kz7nYRWqUEM=";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
