{
  config,
  lib,
  pkgs,
  ...
}: let
  aliases = {
    cat = "${lib.getExe pkgs.bat}";
    cp = "${pkgs.coreutils}/bin/cp -riv";
    df = "${lib.getExe pkgs.grc} ${pkgs.coreutils}/bin/df -h";
    grep = "${lib.getExe pkgs.ripgrep}";
    mkdir = "${pkgs.coreutils}/bin/mkdir -vp";
    mv = "${pkgs.coreutils}/bin/mv -iv";
    rga = "${lib.getExe pkgs.ripgrep} -uu";
    su = "su -";
    tk = "${lib.getExe pkgs.tmux} kill-session -t";
    tl = "${lib.getExe pkgs.tmux} ls";
    ts = "${lib.getExe pkgs.sessionizer}";
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
      history.path = "${config.home.homeDirectory}/.local/share/zsh/.zsh_history";
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
        if [[ -f /opt/homebrew/bin/brew ]] then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
      initExtra = ''
        function frg {
              result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
                fzf --ansi \
                    --color 'hl:-1:underline,hl+:-1:underline:reverse' \
                    --delimiter ':' \
                    --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
                    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
              file=''${result%%:*}
              echo "$file"
              linenumber=$(echo "''${result}" | cut -d: -f2)
              echo "$linenumber"
              if [[ -n "$file" ]]; then
                      $EDITOR +"''${linenumber}" "$file"
              fi
          }
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

    zoxide = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };

    fzf = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
      defaultCommand = "${pkgs.fd}/bin/fd --type f";
      fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    };
  };

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth" = {
        directories = [".local/share/zoxide" ".local/share/zsh"];
      };
    };
  };
}
