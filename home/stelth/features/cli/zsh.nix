{
  config,
  lib,
  pkgs,
  ...
}: let
  aliases = rec {
    ls = "${pkgs.coreutils}/bin/ls --color=auto -h";
    la = "${ls} -a";
    ll = "${ls} -la";
    lt = "${ls} -lat";
    ts = "${lib.getExe pkgs.sessionizer}";
    tl = "${lib.getExe pkgs.tmux} ls";
    tk = "${lib.getExe pkgs.tmux} kill-session -t";
    mv = "${pkgs.coreutils}/bin/mv -iv";
    cp = "${pkgs.coreutils}/bin/cp -riv";
    mkdir = "${pkgs.coreutils}/bin/mkdir -vp";
    su = "su -";
    df = "${lib.getExe pkgs.grc} ${pkgs.coreutils}/bin/df -h";
    rga = "${lib.getExe pkgs.ripgrep} -uu";
    grep = "${lib.getExe pkgs.ripgrep}";
  };
in {
  programs = {
    zsh = let
      mkZshPlugin = {
        pkg,
        file ? "${pkg.pname}.plugin.zsh",
      }: rec {
        name = pkg.pname;
        inherit (pkg) src;
        inherit file;
      };
    in {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      localVariables = {
        LANG = "en_US.UTF-8";
        GPG_TTY = "/dev/ttys000";
        DEFAULT_USER = "${config.home.username}";
        CLICOLOR = 1;
        LS_COLORS = "ExFxBxDxCxegedabagacad";
      };
      sessionVariables = {
        LLDB_DEBUGSERVER_PATH = "/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver";
      };
      shellAliases = aliases;
      initExtraBeforeCompInit = ''
        fpath+=~/.zfunc
      '';
      plugins = with pkgs; [
        (mkZshPlugin {pkg = zsh-autopair;})
        (mkZshPlugin {pkg = zsh-completions;})
        (mkZshPlugin {pkg = zsh-autosuggestions;})
        (mkZshPlugin {
          pkg = zsh-fast-syntax-highlighting;
          file = "fast-syntax-highlighting.plugin.zsh";
        })
        (mkZshPlugin {pkg = zsh-history-substring-search;})
      ];
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
    };
  };
}
