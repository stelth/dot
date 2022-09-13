{
  config,
  lib,
  pkgs,
  ...
}: let
  home = config.home.homeDirectory;
  darwinSockPath = "${home}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  sockPath = "~/.1password/agent.sock";
in {
  home.sessionVariables.SSH_AUTH_SOCK = sockPath;
  home.file = {
    sock = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
      target = ".1password/agent.sock";
    };
    sshConfig = {
      text = ''
        Host *
          IdentityAgent "${sockPath}"
      '';
      target = ".1password/ssh_config";
    };
  };
}
