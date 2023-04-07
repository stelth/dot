{config, ...}: {
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["${config.user.name}"];
  };

  networking.networkmanager.enable = true;
}
