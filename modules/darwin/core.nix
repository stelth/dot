{ inputs, config, pkgs, ... }:
let
  prefix = "/run/current-system/sw/bin";
in
{
  environment = {
    loginShell = pkgs.fish;
    pathsToLink = [ "/Applications" ];
    etc = {
      darwin.source = "${inputs.darwin}";
    };
  };

  fonts.enableFontDir = true;
  nix.nixPath = [ "darwin=/etc/${config.environment.etc.darwin.target}" ];

  users.nix.configureBuildUsers = true;

  services.nix-daemon.enable = false;

  system.stateVersion = 4;
}
