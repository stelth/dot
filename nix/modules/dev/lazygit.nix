{ pkgs, ... }:
{
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
      git = {
        pull = {
          mode = "merge";
        };
      };
      quitOnTopLevelReturn = true;
      keybinding = {
        universal = {
          startSearch = "/";
        };
        status = {
          allBranchesLogGraph = "a";
        };
        branches = {
          copyPullRequestURL = "<c-y>";
          renameBranch = "R";
        };
        commits = {
          markCommitAsFixup = "F";
        };
      };
      disableStartupPopups = true;
    };
  };
}
