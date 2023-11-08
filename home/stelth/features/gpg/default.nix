{
  pkgs,
  config,
  ...
}: let
  pinentry =
    if config.gtk.enable
    then {
      packages = [pkgs.pinentry-gnome pkgs.gcr];
      name = "gnome3";
    }
    else {
      package = [pkgs.pinentry-curses];
      name = "curses";
    };
in {
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };

  programs = let
    fixGpg = ''
      gpgconf --launch gpg-agent
    '';
  in {
    bash.profileExtra = fixGpg;
    fish.loginShellInit = fixGpg;
    zsh.loginExtra = fixGpg;

    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      publicKeys = [
        {
          source = ../../pgp.asc;
          trust = 5;
        }
      ];
    };
  };

  systemd.user.services = {
    link-gnupg-sockets = {
      Unit = {
        Description = "Link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
