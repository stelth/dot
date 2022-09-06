{ inputs, config, pkgs, ... }:
let prefix = "/run/current-system/sw/bin";
in {
  environment = {
    loginShell = pkgs.fish;
    pathsToLink = [ "/Applications" ];
    etc = { darwin.source = "${inputs.darwin}"; };
  };

  nix = {
    configureBuildUsers = true;
    nixPath = [ "darwin=/etc/${config.environment.etc.darwin.target}" ];
    extraOptions = ''
      extra-platforms = x86_64-darwin
    '';
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
