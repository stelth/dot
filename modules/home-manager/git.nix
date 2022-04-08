{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ github-cli ];

  programs.git = {
    userName = "Jason Cox";
    extraConfig = {
      color = { ui = true; };
      pull = {
        ff = "only";
        rebase = false;
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
      init = { defaultBranch = "main"; };
      diff = { tool = "nvimdiff"; };
      "difftool \"nvimdiff\"" = { cmd = ''nvim -d "$LOCAL" "$REMOTE"''; };
      merge = {
        tool = "nvim_mergetool";
        conflictstyle = "diff3";
      };
      "mergetool \"nvim_mergetool\"" = {
        cmd =
          ''nvim -f -c "MergetoolStart" "$MERGED" "$BASE" "$LOCAL" "$REMOTE"'';
        trustExitCode = true;
      };
      ghq = { root = "~/dev/repos"; };
      credentials = {
        helper = if pkgs.stdenvNoCC.isDarwin then
          "osxkeychain"
        else
          "cache --timeout=1000000000";
      };
      http = { sslVerify = true; };
      commit = { verbose = true; };
    };
    lfs.enable = true;
  };
}
