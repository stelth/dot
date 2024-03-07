{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [polkit_gnome];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = builtins.attrNames config.home-manager.users;
  };
}
