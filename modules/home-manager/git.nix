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
      delta = {
        side-by-side = false;
        line-numbers = true;
      };
      init = { defaultBranch = "main"; };
      diff = { tool = "nvimdiff"; };
      "difftool \"nvimdiff\"" = { cmd = ''nvim -d "$LOCAL" "$REMOTE"''; };
      merge = { tool = "nvimdiff"; };
      mergetool = { keepBackup = false; };
      "mergetool \"nvimdiff\"" = {
        cmd =
          ''nvim "$LOCAL" "$REMOTE" "$MERGED" -c "$wincmd w" -c "$wincmd J"'';
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
    delta.enable = true;
    lfs.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          activeBorderColor = [ "green" "bold" ];
          inactiveBorderColor = [ "white" ];
          optionsTextColor = [ "blue" ];
          selectedLineBgColor = [ "reverse" ];
          selectedRangeBgColor = [ "blue" ];
        };
      };
      git = { pull = { mode = "merge"; }; };
      quitOnTopLevelReturn = true;
      keybinding = {
        universal = { startSearch = "/"; };
        status = { allBranchesLogGraph = "a"; };
        branches = {
          copyPullRequestURL = "<c-y>";
          renameBranch = "R";
        };
        commits = { markCommitAsFixup = "F"; };
      };
      disableStartupPopups = true;
    };
  };
}
