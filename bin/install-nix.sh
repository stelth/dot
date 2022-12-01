#! /usr/bin/env bash

URL="https://nixos.org/nix/install"

[[ -n $1 ]] && URL="$1"

if command -v nix >/dev/null; then
  echo "nix is already installed on this system."
else
  bash <(curl -L "$URL") --daemon
fi

NIX_CONF_PATH=/etc/nix
if [[ ! -d $NIX_CONF_PATH ]]; then
  mkdir -p "$NIX_CONF_PATH"
fi

if [[ ! -f $NIX_CONF_PATH/nix.conf ]] || ! grep "experimental-features" <"$NIX_CONF_PATH"; then
  echo "experimental-features = nix-command flakes" | sudo tee -a "$NIX_CONF_PATH"/nix.conf
fi
