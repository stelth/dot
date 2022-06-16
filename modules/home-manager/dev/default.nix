{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    cmake
    gh
    hub
    lua
    maven
    ninja
    nodejs_latest
    openjdk
    rustc
    cargo
    tmux-sessionizer
    tmux-cht

    tree-sitter
    fd
    fzy

    # C/C++
    clang_14
    clang-tools_14
    cppcheck
    lldb_14

    # Java
    jdt-language-server

    #nix
    nixfmt
    rnix-lsp
    statix

    # python
    (python3.withPackages (ps: with ps; [ autopep8 flake8 isort yamllint ]))
    nodePackages.pyright

    # Lua
    selene
    stylua
    sumneko-lua-language-server

    # Shell scripting
    nodePackages.bash-language-server
    shellcheck
    shellharden
    shfmt

    # Additional
    cmake-language-server
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server

  ];

  programs.ssh = {
    enable = true;
    includes = [ "~/.1password/ssh_config" ];

    matchBlocks = {
      "10.* 172.* 192.*" = {
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/keys/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = { "StrictHostKeyChecking" = "no"; };
      };
      "github.com" =
        lib.hm.dag.entryBefore [ "10.* 172.* 192.*" ] { user = "stelth"; };
      "10.137.25.4 10.137.26.4 172.19.22.112" =
        lib.hm.dag.entryBefore [ "github.com" ] {
          user = "root";
          identitiesOnly = true;
          identityFile = "~/.ssh/keys/id_rsa.build_node";
          serverAliveInterval = 50;
          extraOptions = { "StrictHostKeyChecking" = "no"; };
        };
      "github.ibm.com" = lib.hm.dag.entryBefore [ "github.com" ] {
        user = "Jason.P.Cox@ibm.com";
      };
      "9.47.32.9" = lib.hm.dag.entryBefore [ "github.com" ] { user = "jcox"; };
    };
  };
}
