{ inputs, lib, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.stable { inherit (prev) system; };
      small = import inputs.small { inherit (prev) system; };
    })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      lldb = prev.lldb.overrideAttrs (old: {
        patches = (old.patches or [ ])
          ++ [ ./patches/lldb-fix-cpu-subtype-not-found.patch ];
      });
    })
  ];
}
