{ inputs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      stable = import inputs.stable { inherit (super) system; };
      small = import inputs.small { inherit (super) system; };
    })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs/tmux-sessionizer.nix)
  ];
}
