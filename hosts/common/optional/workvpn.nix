{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [vpnc];

  environment.etc."vpnc/workvpn.conf" = {
    source = config.sops.secrets.workvpn_config.path;
  };

  sops.secrets.workvpn_config = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };
}
