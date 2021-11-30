{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: { stable = import stable { system = prev.system; }; })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      sumneko-lua-language-server =
        prev.sumneko-lua-language-server.overrideAttrs (o: rec {
          version = "2.5.1";

          src = builtins.fetchurl {
            url =
              "https://github.com/sumneko/vscode-lua/releases/download/v${version}/lua-${version}.vsix";
            sha256 = "0a48jg8pa3v7m956nz2dd7pzcpvxcbqlf3diqg1qax7f0p3blnm7";
          };

          unpackPhase = ''
            ${prev.pkgs.unzip}/bin/unzip $src
          '';

          postPatch = "";

          platform = if prev.stdenv.isDarwin then "macOS" else "Linux";

          preBuild = "";
          postBuild = "";
          nativeBuildInputs = [ prev.makeWrapper ];

          dontPatch = true;

          installPhase = ''
            mkdir -p $out
            cp -r extension $out/extras
            chmod a+x $out/extras/server/bin/$platform/lua-language-server
            makeWrapper $out/extras/server/bin/$platform/lua-language-server \
            $out/bin/lua-language-server \
            --add-flags "-E -e LANG=en $out/extras/server/main.lua \
            --logpath='~/.cache/sumneko_lua/log' \
            --metapath='~/.cache/sumneko_lua/meta'"
          '';

          meta.platforms = prev.lib.platforms.all;
        });
    })
    (final: prev: rec {
      # fix yabai for monterey
      # thanks to https://github.com/DieracDelta/flakes/blob/flakes/flake.nix#L382
      yabai = let
        buildSymlinks = prev.runCommand "build-symlinks" { } ''
          mkdir -p $out/bin
          ln -s /usr/bin/xcrun /usr/bin/xcodebuild /usr/bin/tiffutil /usr/bin/qlmanage $out/bin
        '';
      in prev.yabai.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "koekeishiya";
          repo = "yabai";
          rev = "5317b16d06e916f0e3844d3fe33d190e86c96ba9";
          sha256 = "sha256-yl5a6ESA8X4dTapXGd0D0db1rhwhuOWrjFAT1NDuygo=";
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
