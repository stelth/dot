{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "neocmakelsp";
  version = "3a14498147c5c7bcd98baf0c90976c1c5430d24c";

  src = fetchFromGitHub {
    owner = "Decodetalkers";
    repo = pname;
    rev = version;
    sha256 = "sha256-5cuHWzWjeV9c/y1FaR4sdCWKLkUqpfOpfX1QqDloRX0=";
  };

  cargoHash = "sha256-gjGhb/kdGJId2zM18OMuLx4Ci0wRS4WIpbgdb9NTsuQ=";

  nativeBuildInputs = with pkgs; [cmake];

  meta = with lib; {
    description = "CMake lsp based on Tower and treesitter";
    homepage = "https://github.com/Decodetalkers/neocmakelsp";
    license = licenses.mit;
    maintainers = [maintainers.tailhook];
  };
}
