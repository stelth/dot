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
      vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {};
    };

  modifications = final: prev: {
    pfetch = prev.pfetch.overrideAttrs (oa: {
      version = "unstable-2021-12-10";
      src = final.fetchFromGitHub {
        owner = "dylanaraps";
        repo = "pfetch";
        rev = "a906ff89680c78cec9785f3ff49ca8b272a0f96b";
        sha256 = "sha256-9n5w93PnSxF53V12iRqLyj0hCrJ3jRibkw8VK3tFDvo=";
      };
      patches = (oa.patches or []) ++ [./pfetch.patch];
    });
  };
}
