{ config, pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "10.* 172.18.30.* 172.19.* 192.168.*" = {
        user = "root";
        identityFile = "~/dot/config/ssh/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
      };
      "github.com" = lib.hm.dag.entryBefore [ "10.* 172.18.30.* 172.19.* 192.168.*" ] {
        user = "stelth";
        identityFile = "~/dot/config/ssh/id_ed25519_github";
      };
      "github.ibm.com" = lib.hm.dag.entryBefore [ "github.com" ] {
        user = "Jason.P.Cox@ibm.com";
        identityFile = "~/dot/config/ssh/id_ed25519_ibm";
      };
    };
  };
}
