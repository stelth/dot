{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment = {
    loginShell = pkgs.zsh;
    pathsToLink = ["/Applications"];
    etc = {darwin.source = "${inputs.darwin}";};
  };

  nix = {
    configureBuildUsers = true;
    nixPath = ["darwin=/etc/${config.environment.etc.darwin.target}"];
    extraOptions = ''
      extra-platforms = x86_64-darwin
    '';
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [nerdfonts ibm-plex];
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
  documentation.enable = false;
}
