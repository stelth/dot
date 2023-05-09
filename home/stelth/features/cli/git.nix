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
      user.signing.key = "0018 9A59 45CB 9297 04BD  AACF 9283 5489 E0CA B55B";
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
