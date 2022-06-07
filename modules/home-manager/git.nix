{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ github-cli ];

  programs.git = {
    userName = "Jason Cox";
    extraConfig = {
      credential = {
        helper = if pkgs.stdenvNoCC.isDarwin then
          "osxkeychain"
        else
          "cache --timeout=1000000000";
      };
      commit = { verbose = true; };
      fetch = { prune = true; };
      http = { sslVerify = true; };
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { followTags = true; };
      ghq = { root = "~/dev/repos"; };
      color = { ui = true; };
    };
    aliases = {
      fix = "commit --amend --no-edit";
      oops = "reset HEAD~1";
      sub = "submodule update --init --recursive";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = false;
        line-numbers = true;
      };
    };

    lfs.enable = true;
  };
}
