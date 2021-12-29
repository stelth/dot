{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: { stable = import stable { system = prev.system; }; })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      sumneko-lua-language-server =
        prev.sumneko-lua-language-server.overrideAttrs (o: rec {
          version = "2.5.6";

          src = builtins.fetchurl {
            url =
              "https://github.com/sumneko/vscode-lua/releases/download/v${version}/vscode-lua-v${version}-darwin-x64.vsix";
            sha256 = "0xyma867h4ssngnpa95n4qv6103qc81yj6ylhrir8n3cbs5izz9w";
          };

          unpackPhase = ''
            ${prev.pkgs.unzip}/bin/unzip $src
          '';

          postPatch = "";

          preBuild = "";
          postBuild = "";
          nativeBuildInputs = [ prev.makeWrapper ];

          dontPatch = true;

          installPhase = ''
            mkdir -p $out
            cp -r extension $out/extras
            chmod a+x $out/extras/server/bin/lua-language-server
            makeWrapper $out/extras/server/bin/lua-language-server \
            $out/bin/lua-language-server \
            --add-flags "-E -e LANG=en $out/extras/server/main.lua \
            --logpath='~/.cache/sumneko_lua/log' \
            --metapath='~/.cache/sumneko_lua/meta'"
          '';

          meta.platforms = prev.lib.platforms.all;
        });
    })
    (final: prev: rec {
      yabai = let
        buildSymlinks = prev.runCommand "build-symlinks" { } ''
          mkdir -p $out/bin
          ln -s /usr/bin/xcrun /usr/bin/xcodebuild /usr/bin/tiffutil /usr/bin/qlmanage $out/bin
        '';
      in prev.yabai.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "koekeishiya";
          repo = "yabai";
          rev = "f403e609e32b4100494c5afb089d0010e7e4ef91";
          sha256 = "sha256-Lzim9h9aZopS7BjLzGghZQpgHx183psTLHCM9ndJCXo=";
        };
        buildInputs = with prev.darwin.apple_sdk.frameworks; [
          Carbon
          Cocoa
          ScriptingBridge
          prev.xxd
          SkyLight
        ];
        nativeBuildInputs = [ buildSymlinks ];
      });
    })
    (final: prev:
      let lib = prev.lib;
      in rec {
        python3 = prev.python3.override {
          packageOverrides = final: prev: {
            beautifulsoup4 = prev.beautifulsoup4.overrideAttrs (old: {
              propagatedBuildInputs =
                lib.remove prev.lxml old.propagatedBuildInputs;
            });
          };
        };
        python3Packages = python3.pkgs;
      })
  ];
}
