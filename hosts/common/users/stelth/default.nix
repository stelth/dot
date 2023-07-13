{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.stelth = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "audio"
        "video"
      ]
      ++ ifTheyExist [
        config.users.groups.keys.name
        "networkmanager"
        "libvirtd"
        "scanner"
        "lp"
      ];

    openssh.authorizedKeys.keys = [(builtins.readFile ../../../../home/stelth/ssh.pub)];
    passwordFile = config.sops.secrets.stelth-password.path;

    packages = [pkgs.home-manager];
  };

  sops.secrets.stelth-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.stelth = import home/${config.networking.hostName}.nix;

  security.pam.services = {swaylock = {};};
}
