{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    includes = ["~/.1password/ssh_config"];

    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    matchBlocks = {
      net = {
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
      "10.140.100.*" = lib.hm.dag.entryBefore ["10.137.24.4 10.137.23.4 10.137.25.4 10.137.26.4 172.19.22.112"] {
        user = "jcox";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519";
        serverAliveInterval = 50;
        extraOptions = {
          "StrictHostKeyChecking" = "no";
        };
      };
      "github.ibm.com" = lib.hm.dag.entryBefore ["github.com"] {
        user = "Jason.P.Cox@ibm.com";
      };
      "9.47.32.9" = lib.hm.dag.entryBefore ["github.com"] {user = "jcox";};
    };
  };

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [".ssh"];
    };
  };
}
