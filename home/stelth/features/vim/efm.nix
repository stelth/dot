{...}: ''
  version: 2
  root-markers:
    - .git/

  tools:
    sh-shellcheck: &sh-shellcheck
      lint-command: 'shellcheck -f gcc -x'
      lint-source: shellcheck
      lint-formats:
        - '%f:%l:%c: %trror: %m'
        - '%f:%l:%c: %tarning: %m'
        - '%f:%l:%c: %tote: %m'

    sh-shfmt: &sh-shfmt
      format-command: 'shfmt -ci -s -bn'
      format-stdin: true

    clang-format: &clang-format
      format-command: 'clang-format'
      format-stdin: true

    clang-tidy: &clang-tidy
      lint-command: 'clang-tidy'
      lint-source: clang-tidy
      lint-stdin: false
      lint-ignore-exit-code: true
      lint-formats:
        - '%f:%l:%c: %trror: %m'
        - '%f:%l:%c: %tarning: %m'
        - '%f:%l:%c: %tote: %m'

    cpplint: &cpplint
      lint-command: 'cpplint'
      lint-source: cpplint
      lint-stdin: false
      lint-ignore-exit-code: true
      lint-formats:
        - '%.%#.%l: %m'

  languages:
    sh:
      - <<: *sh-shellcheck
      - <<: *sh-shfmt
    c:
      - <<: *clang-format
      - <<: *clang-tidy
      - <<: *cpplint
    cpp:
      - <<: *clang-format
      - <<: *clang-tidy
      - <<: *cpplint
''
# CMake
# cmake-format
# Docker
# dprint
# hadolint
# Git
# gitlint
# Java
# google-java-format
# JSON
# nodePackages.fixjson
# Markdown
# nodePackages.prettier
# vale
# nodePackages.write-good
# Nix
# alejandra
# statix
# Python
# (python3.withPackages
# (ps: with ps; [black flake8 isort pylint]))
# Vim
# vim-vint
# YAML
# yamllint
# ]
# ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

