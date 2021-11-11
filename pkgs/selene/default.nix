{ lib, rustPlatform, fetchFromGitHub, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "selene";
  version = "0.15.0";
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
    sha256 = "sha256-tA1exZ97N2tAagAljt+MOSGh6objOiqbZXUaBZ62Sls";
  };
  cargoSha256 = "sha256-4vCKiTWwnibNK6/S1GOYRurgm2Aq1e9o4rAmp0hqGeA";

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.mpl20;
    maintainers = [ maintainers.tailhook ];
  };
}
