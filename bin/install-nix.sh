#! /usr/bin/env bash

RELEASE="nix-2.5pre20211026_5667822"
URL="https://github.com/numtide/nix-unstable-installer/releases/download/$RELEASE/install"

# install using workaround for darwin systems
[[ $(uname -s) = "Darwin" ]] && FLAG="--darwin-use-unencrypted-nix-store-volume"
[[ -n "$1" ]] && URL="$1"

if command -v nix >/dev/null; then
	echo "nix is already installed on this system."
else
	bash <(curl -L "$URL") --daemon "$FLAG"
fi
