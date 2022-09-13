{
  config,
  lib,
  options,
  ...
}: let
  inherit (lib) mkAliasDefinitions mkOption types;
in {
  options = {
    user = mkOption {
      description = "Primary user configuration";
      type = types.attrs;
      default = {};
    };

    hm = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = {
    home-manager.users.${config.user.name} = mkAliasDefinitions options.hm;

    users.users.${config.user.name} = mkAliasDefinitions options.user;
  };
}
