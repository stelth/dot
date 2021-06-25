#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

WORK_DIR=$(mktemp -d)

pushd $WORK_DIR

os=$(uname -s | tr "[:upper:]" "[:lower:]")
case $os in
	linux)
		platform="Linux"
		;;
	darwin)
		platform="macOS"
		;;
esac

curl -L -o sumneko-lua.vsix $(curl -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)
unzip sumneko-lua.vsix -d sumneko-lua
rm sumneko-lua.vsix

chmod +x sumneko-lua/extension/server/bin/$platform/lua-language-server

echo "#!/usr/bin/env bash" >lua-language-server
echo "\$(dirname \$0)/sumneko-lua/extension/server/bin/$platform/lua-language-server -E -e LANG=en \$(dirname \$0)/sumneko-lua/extension/server/main.lua \$*" >>lua-language-server

chmod +x lua-language-server

if [ -d ~/.local/bin/sumneko-lua ]; then
	rm -rf ~/.local/bin/sumneko-lua
fi

if [ -e ~/.local/bin/lua-language-server ]; then
	rm -rf ~/local/bin/lua-language-server
fi

mv sumneko-lua ~/.local/bin
mv lua-language-server ~/.local/bin

popd

rm -rf "${WORK_DIR}"
