#!/usr/bin/env -S nix shell nixpkgs#httpie nixpkgs#jq --command bash

function fetch_image() {
	jq -n \
		--arg name "$(echo $1 | cut -d '|' -f 1)" \
		--arg ext "$(echo $1 | cut -d '|' -f 2 | cut -d '/' -f 2)" \
		--arg id "$(echo $1 | cut -d '|' -f 3)" \
		--arg sha256 "$(nix-prefetch-url https://i.imgur.com/$id.$ext)" \
		'{"name": $name, "ext": $ext, "id": $id, "sha256": $sha256}'
}

album="bXDPRpV" # https://imgur.com/a/bXDPRpV
clientid="d96b25e49d7b8f3"

result=$(https api.imgur.com/3/album/$album Authorization:"Client-ID $clientid")
images=$(echo $result | jq -r '.data.images[] | "\(.description)|\(.type)|\(.id)"')

echo "["
while read -r image; do
	fetch_image $image
done <<<"$images"
wait
echo "]"
