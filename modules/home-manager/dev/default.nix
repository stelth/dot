{ config, pkgs, lib, ... }:
let
  globalPythonPkgs = python-packages:
    with python-packages; [
      debugpy
      autopep8
      flake8
    ];
  globalPython = pkgs.python3.withPackages globalPythonPkgs;
in {
  home.packages = with pkgs; [
    globalPython
    cmake
    gh
    ghc
    hub
    lua
    maven
    ninja
    nodejs_latest
    openjdk
    rustc
    cargo
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "10.* 172.* 192.*" = {
        user = "root";
        identityFile = "~/.ssh/keys/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = { "StrictHostKeyChecking" = "no"; };
      };
      "github.com" = lib.hm.dag.entryBefore [ "10.* 172.* 192.*" ] {
        user = "stelth";
        identityFile = "~/.ssh/keys/github_personal_private_key";
      };
      "github.ibm.com" = lib.hm.dag.entryBefore [ "github.com" ] {
        identityFile = "~/.ssh/keys/github_ibm_private_key";
        user = "Jason.P.Cox@ibm.com";
      };
      "9.47.32.9" = lib.hm.dag.entryBefore [ "github.com" ] {
        identityFile = "~/.ssh/keys/id_ed25519_logserver";
        user = "Jason.P.Cox";
      };
    };
  };
}
