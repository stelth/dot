{pkgs, ...}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "gersemi";
  version = "0.11.0";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-K8ZbVVYiEazdjbuAUa8r9lJyjOPt2jsKbUAovTx9XeY=";
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
