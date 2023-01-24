{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-KHlsyNgGm5+l7aqzoUdlOKJ4gb6KmJlCegQTAWqm4GI=";
  };

  cargoHash = "sha256-s5I0NoyX05kfpyPxwQdIaoLeb9rLSuWTuQXrGkYyhaw=";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
