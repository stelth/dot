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

  services.gnome.gnome-keyring.enable = true;

  systemd = {
    user.services = {
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
