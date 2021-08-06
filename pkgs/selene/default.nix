{ lib, rustPlatform, fetchFromGitHub, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "selene";
  version = "0.13.0";
  stdenv = pkgs.clangStdenv;

  isDarwin = pkgs.stdenv.isDarwin;

  darwinPackages = with pkgs.darwin.apple_sdk.frameworks; [
    Security
    CoreFoundation
    CoreServices
  ];

  linuxPackages = with pkgs; [];

  buildInputs = [
    pkgs.rustc
    pkgs.cargo
  ] ++ (
    if isDarwin then darwinPackages else linuxPackages
  );

  src = fetchFromGitHub {
    owner = "Kampfkarren";
    repo = pname;
    rev = version;
    sha256 = "150sgbjb2d4cdn4vi1ygyk1wpd62nzqpaa1gjyzjcq3f8wd24780";
  };

  cargoSha256 = "sha256-Daz4SMznW6TS9EvpGjMTHYZLSLCrsZWSykLhpJsYphE=";

  meta = with lib;
    {
      description = "";
      homepage = "";
      license = licenses.mpl20;
      maintainers = [ maintainers.tailhook ];
    };
}
