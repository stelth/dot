{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: { stable = import stable { system = prev.system; }; })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      sumneko-lua-language-server =
        prev.sumneko-lua-language-server.overrideAttrs (o: rec {
          version = "2.6.3";

          src = builtins.fetchurl {
            url =
              "https://github.com/sumneko/vscode-lua/releases/download/v${version}/vscode-lua-v${version}-darwin-x64.vsix";
            sha256 = "1xh2n9w4r5879h57y0dmq2dl76iywaj063nsf3ad36zvhns961dz";
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
          rev = "916d9133f9d13fb38678baa3d0adf3cfb9dff003";
          sha256 = "sha256-RFEuVIMP9+HXnkSPRobCATzg9fsu48zoAFq7AqodLaQ=";
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
    (final: prev: rec {
      lldb = prev.lldb.overrideAttrs (old: {
        patches = (old.patches or [ ])
          ++ [ ./patches/lldb-fix-cpu-subtype-not-found.patch ];
      });
    })
    (final: prev: rec {
      remarshal = prev.remarshal.overrideAttrs (old: {
        postPatch = ''
                substituteInPlace pyproject.toml \
          --replace "poetry.masonry.api" "poetry.core.masonry.api" \
          --replace 'PyYAML = "^5.3"' 'PyYAML = "*"' \
          --replace 'tomlkit = "^0.7"' 'tomlkit = "*"'
        '';
      });
    })
    (final: prev:
      let lib = prev.lib;
      in rec {
        python3 = prev.python3.override {
          packageOverrides = final: prev: {
            ipython = prev.ipython.overrideAttrs (old: {
              preCheck = old.preCheck
                + lib.optionalString prev.stdenv.isDarwin ''
                  # Fake the impure dependencies pbpaste and pbcopy
                  echo "#!${prev.stdenv.shell}" > pbcopy
                  echo "#!${prev.stdenv.shell}" > pbpaste
                  chmod a+x pbcopy pbpaste
                  export PATH=$(pwd):$PATH
                '';
            });
          };
        };
        python3Packages = python3.pkgs;
      })
    (final: prev: {
      haskell-language-server = prev.haskell-language-server.override {
        supportedGhcVersions = [ "8107" "921" ];
      };
    })
  ];
}
