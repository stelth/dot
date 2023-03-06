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

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
  documentation.enable = false;
}
