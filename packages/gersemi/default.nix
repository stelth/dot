{pkgs, ...}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "gersemi";
  version = "0.9.3";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "fNhmq9KKOwlc50iDEd9pqHCM0br9Yt+nKtrsoS1d5ng=";
  };

  nativeBuildInputs = with pkgs.python3Packages; [
    setuptools
  ];

  doCheck = false;

  propagatedBuildInputs = with pkgs.python3Packages; [
    appdirs
    # dataclasses
    lark
    pyyaml
  ];
}
