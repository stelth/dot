{
  outputs,
  lib,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
  programs.ssh = {
    enable = true;
    includes = ["~/.1password/ssh_config"];

    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " hostnames;
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = ''/%d/.gnupg-sockets/S.gpg-agent'';
            host.address = ''/%d/.gnupg-sockets/S.gpg-agent.extra'';
          }
        ];
      };
      "10.* 172.* 192.*" = {
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/keys/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = {"StrictHostKeyChecking" = "no";};
      };
      "github.com" =
        lib.hm.dag.entryBefore ["10.* 172.* 192.*"] {user = "stelth";};
      "10.137.24.4 10.137.23.4 10.137.25.4 10.137.26.4 172.19.22.112" = lib.hm.dag.entryBefore ["github.com"] {
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/keys/id_rsa.build_node";
        serverAliveInterval = 50;
        extraOptions = {"StrictHostKeyChecking" = "no";};
      };
      "github.ibm.com" = lib.hm.dag.entryBefore ["github.com"] {
        user = "Jason.P.Cox@ibm.com";
      };
      "9.47.32.9" = lib.hm.dag.entryBefore ["github.com"] {user = "jcox";};
    };
  };

  home.persistence = {
    "/persist/home/stelth".directories = [".ssh"];
  };
}
