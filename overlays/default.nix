{inputs, ...}: {
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (_: flake: (flake.packages or flake.legacyPackages or {}).${final.system} or {}) inputs;
  };

  channels = final: prev: {
    stable = import inputs.stable {inherit (prev) system;};
    small = import inputs.small {inherit (prev) system;};
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
    };

  modifications = final: prev: {
  };

  vim-extra-plugins = inputs.vim-extra-plugins.overlays.default;
}
