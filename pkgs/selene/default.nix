{ lib, rustPlatform, fetchFromGitHub, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "selene";
  version = "0.16.0";
  stdenv = pkgs.clangStdenv;

  inherit (pkgs.stdenv) isDarwin;

  darwinPackages = with pkgs.darwin.apple_sdk.frameworks; [
    Security
    CoreFoundation
    CoreServices
  ];

  linuxPackages = with pkgs; [ ];

  buildInputs = [ pkgs.rustc pkgs.cargo ]
    ++ (if isDarwin then darwinPackages else linuxPackages);

  src = fetchFromGitHub {
    owner = "Kampfkarren";
    repo = pname;
    rev = version;
    sha256 = "sha256-S0EeFJS90bzQ7C+hN4CyZ7l9wmizT2d3P6utshI5JWs=";
  };
  cargoSha256 = "sha256-3J1Q595LxAI0LBP4/cLHDrMbZBnoA2+OSr8/erQcN+0=";

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.mpl20;
    maintainers = [ maintainers.tailhook ];
  };
}
