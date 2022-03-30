{ inputs, lib, ... }: {
  nixpkgs.overlays = [
    (final: prev: { stable = import inputs.stable { system = prev.system; }; })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      lldb = prev.lldb.overrideAttrs (old: {
        patches = (old.patches or [ ])
          ++ [ ./patches/lldb-fix-cpu-subtype-not-found.patch ];
      });
    })
    (final: prev: {
      haskell-language-server = prev.haskell-language-server.override {
        supportedGhcVersions = [ "8107" "921" ];
      };
    })
    (final: prev: rec {
      kitty = prev.kitty.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./patches/kitty-fix-ldflags.patch ];
      });
    })
  ];
}
