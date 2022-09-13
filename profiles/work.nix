{
  config,
  lib,
  pkgs,
  ...
}: {
  user.name = "coxj";
  hm = {imports = [./home-manager/work.nix];};
}
