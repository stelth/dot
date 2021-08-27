{ lib, rustPlatform, fetchFromGitHub, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "selene";
  version = "0.14.0";
  stdenv = pkgs.clangStdenv;

  isDarwin = pkgs.stdenv.isDarwin;

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
    sha256 = "0c228aakwf679wyxir0jwry3khv7phlaf77w675gn1wr4fxdg5gr";
  };
  cargoSha256 = "sha256-5GODuqjVo3b1SzRgXVBIKec2tSS335EAUAmRlcpbClE=";

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.mpl20;
    maintainers = [ maintainers.tailhook ];
  };
}
