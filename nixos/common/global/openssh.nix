{
  outputs,
  lib,
  config,
  ...
}: let
  inherit (config.networking) hostName;
  hosts = outputs.nixosConfigurations;
  pubKey = host: ../../${host}/ssh_host_ed25519_key.pub;

  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    settings = {
      GatewayPorts = "clientspecified";
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      UseDns = false;
      X11Forwarding = false;

      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "sntrup761x25519-sha512@openssh.com"
      ];
    };

    authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];

    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh = {
    knownHosts =
      builtins.mapAttrs (name: _: {
        publicKeyFile = pubKey name;
        extraHostNames = lib.optional (name == hostName) "localhost";
      })
      hosts;
  };

  security.pam.sshAgentAuth = {
    enable = true;

    authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
  };
}
