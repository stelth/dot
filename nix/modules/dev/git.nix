{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Jason Cox";
    userEmail = "Jason.P.Cox@ibm.com";
    extraConfig = {
      color = {
        ui = true;
      };
      core = {
        pager = "delta";
      };
      pull = {
        ff = "only";
      };
      github = {
        user = "JasonCoxIBM";
      };
      delta = {
        side-by-side = false;
        line-numbers = true;
      };
      init = {
        default-branch = "main";
      };
      diff = {
        tool = "vimdiff3";
      };
      "difftool \"vimdiff3\"" = {
        path = "nvim";
      };
      merge = {
        tool = "vimdiff3";
      };
      "mergetool \"vimdiff3\"" = {
        path = "nvim";
      };
      ghq = {
        root = "~/dev/repos";
      };
    };
  };
}
