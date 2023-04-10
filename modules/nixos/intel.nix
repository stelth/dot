{
  config,
  pkgs,
  ...
}: {
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["${config.user.name}"];
  };

  networking.networkmanager.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [nerdfonts ibm-plex];
  };
}
