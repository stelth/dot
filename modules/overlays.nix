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
          rev = "297156c02854f21a811f5593504226a040a60414";
          sha256 = "7utBcPcCZ6dRnTwUMLFqiNULmJH2pAJy07WCdKjCmDI=";
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
  ];
}
