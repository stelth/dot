{ inputs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      stable = import inputs.stable { inherit (super) system; };
      small = import inputs.small { inherit (super) system; };
    })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs/tmux-sessionizer.nix)
    (import ../pkgs/tmux-cht.nix)
    (import ../pkgs/switch-back-to-nvim.nix)
    (final: prev: rec {
      lldb_14 = prev.lldb_14.overrideAttrs (old: {
        patches = (old.patches or [ ])
          ++ [ ./patches/lldb-fix-cpu-subtype-not-found.patch ];
      });
    })
    (final: prev: rec {
      kitty = prev.kitty.overrideAttrs (old: { doInstallCheck = false; });
    })
    (final: prev: rec {
      golangci-lint =
        prev.golangci-lint.override { inherit (prev) buildGoModule; };
    })
  ];
}
