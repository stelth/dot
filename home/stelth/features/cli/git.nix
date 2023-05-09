{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Jason Cox";
    userEmail = "steel300@gmail.com";
    extraConfig = {
      commit.verbose = true;
      feature.manyFiles = true;
      fetch.prune = true;
      http.sslVerify = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = true;
      commit.gpgSign = true;
      user.signing.key = " 9C644B3FE3C965D4A4B97AC6D5CE2BFDC4ABA45B";
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [".direnv" "result"];
    aliases = {
      fix = "commit --amend --no-edit";
      oops = "reset HEAD~1";
      sub = "submodule update --init --recursive";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
  };
}
