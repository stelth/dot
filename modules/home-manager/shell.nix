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
    ts = "${lib.getExe pkgs.tmux-sessionizer}";
    tl = "${lib.getExe pkgs.tmux} ls";
    tk = "${lib.getExe pkgs.tmux} kill-session -t";
    mv = "${pkgs.coreutils}/bin/mv -iv";
    cp = "${pkgs.coreutils}/bin/cp -riv";
    mkdir = "${pkgs.coreutils}/bin/mkdir -vp";
    push = "${lib.getExe pkgs.git} push";
    pull = "${lib.getExe pkgs.git} pull";
    su = "su -";
    df = "${lib.getExe pkgs.grc} /bin/df -h";
    rga = "${lib.getExe pkgs.ripgrep} -uu";
    grep = "${lib.getExe pkgs.ripgrep}";
  };
in {
  programs.zsh = let
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
    shellAliases = aliases;
    initExtraBeforeCompInit = ''
      fpath+=~/.zfunc
    '';
    profileExtra = ''
      "${lib.optionalString pkgs.stdenvNoCC.isLinux "[[ -e /etc/profile ]] && source /etc/profile"}"
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

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
}
