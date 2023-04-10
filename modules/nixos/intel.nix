{
  config,
  pkgs,
  ...
}: {
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["${config.user.name}"];
  };

  environment.systemPackages = with pkgs; [google-chrome discord];

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [nerdfonts ibm-plex];
  };
}
