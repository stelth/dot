{ inputs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      stable = import inputs.stable { inherit (super) system; };
      small = import inputs.small { inherit (super) system; };
    })
    inputs.neovim-nightly-overlay.overlay
    inputs.vim-extra-plugins.overlays.default
    (import ../pkgs)
    (final: prev: rec {
      lldb_14 = prev.lldb_14.overrideAttrs (old: {
        patches = (old.patches or [ ])
          ++ [ ./patches/lldb-fix-cpu-subtype-not-found.patch ];
      });
    })
  ];
}
