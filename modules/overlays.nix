{ inputs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.stable { inherit (prev) system; };
      small = import inputs.small { inherit (prev) system; };
    })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
  ];
}
