{lib, ...}: {
  flake.lib = {
    mkPackages = inputs: system:
      builtins.mapAttrs (name: value: let
        legacyPackages = value.legacyPackages.${system} or {};
        packages = value.packages.${system} or {};
      in
        legacyPackages // packages)
      inputs;

    importFilesToAttrs = basePath: files:
      builtins.listToAttrs (map (name:
        lib.nameValuePair name (let
          file = basePath + "/${name}.nix";
          folder = basePath + "/${name}";
        in
          if builtins.pathExists file
          then file
          else folder))
      files);
  };
}
