{ inputs, nixpkgs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: { stable = import stable { system = prev.system; }; })
    inputs.neovim-nightly-overlay.overlay
    (import ../pkgs)
    (final: prev: rec {
      sumneko-lua-language-server =
        prev.sumneko-lua-language-server.overrideAttrs (o: rec {
          version = "2.3.6";

          src = builtins.fetchurl {
            url =
              "https://github.com/sumneko/vscode-lua/releases/download/v${version}/lua-${version}.vsix";
            sha256 = "1v9gkcqw25jq20drd1r73lh6ciq188nh85acc5yngjkagkzpaka9";
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
