{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "Jason.P.Cox@ibm.com";
    userName = "Jason Cox";
    github = { user = "JasonCoxIBM"; };
    extraConfig = {
      http = { sslVerify = true; };
      github = { user = "JasonCoxIBM"; };
    };
  };
}
