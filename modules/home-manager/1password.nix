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
  home = {
    file = {
      sock = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
        target = ".1password/agent.sock";
      };
    };
  };
  programs = {
    bash = {
      initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
        if command -v op >/dev/null; then
          source <(op completion bash)
        fi
      '';
    };
    fish = {
      interactiveShellInit = ''
        op completion fish | source
      '';
    };
    zsh = {
      initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
        if command -v op >/dev/null; then
          eval "$(op completion zsh)"; compdef _op op
        fi
      '';
    };
    ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent "${sockPath}"
      '';
    };
  };
}
