{ config, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "/dev/null";
    serverAliveInterval = 50;

    matchBlocks = {
      "10.* 172.18.30.* 172.19.* 192.168.*" = {
        user = "root";
        identityFile = "~/dot/config/ssh/id_rsa.cleversafelabs";
      };
    };
  };
}
