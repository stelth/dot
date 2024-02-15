{
  lib,
  pkgs,
  ...
}: ''
  version: 2
  root-markers:
    - .git/
  lint-debounce: 1s

  tools:
    shfmt-format: &shfmt-format
      format-command: '${lib.getExe pkgs.shfmt} -ln bash -i 2 -bn -ci -sr -kp'
      format-stdin: true

    gersemi-format: &gersemi-format
      format-command: '${pkgs.gersemi}/bin/gersemi -'
      format-stdin: true

    gitlint-lint: &gitlint-lint
      lint-command: '${lib.getExe pkgs.gitlint}'
      prefix: gitlint
      lint-stdin: true
      lint-formats:
        - '%l: %m: "%r"'
        - '%l: %m'

    fixjson-format: &fixjson-format
      format-command: '${pkgs.nodePackages.fixjson}/lib/node_modules/fixjson/bin/main.js'
      format-stdin: true

    checkmake-lint: &checkmake-lint
      lint-command: 'checkmake'
      lint-stdin: true

    alejandra-format: &alejandra-format
      format-command: '${lib.getExe pkgs.alejandra} --quiet'
      format-stdin: true

    statix-lint: &statix-lint
      prefix: statix
      lint-command: '${lib.getExe pkgs.statix} check --stdin --format=errfmt'
      lint-stdin: true
      lint-ignore-exit-code: true
      lint-formats:
        - '<stdin>%l:%c:%t:%m'

    black-action-format: &black-action-format
      commands:
        - title: 'black format'
          command: black
          arguments:
            - '--quiet'
            - '--safe'
            - ' ''${INPUT}'

    flake8-lint: &flake8-lint
      prefix: flake8
      lint-command: '${lib.getExe pkgs.python3Packages.flake8} --stdin-display-name ''${INPUT} -'
      lint-stdin: true
      lint-formats:
        - '%f:%l:%c: %m'

    isort-format: &isort-format
      format-command: '${lib.getExe pkgs.python3Packages.isort} --quiet -'
      format-stdin: true

    pylint-lint: &pylint-lint
      prefix: pylint
      lint-command: '${pkgs.python3Packages.pylint}/bin/pylint --output-format=text --score=no --msg-template {path}:{line}:{column}:{C}:{msg} ''${INPUT}'
      lint-stdin: false
      lint-formats:
        - '%f:%l:%c:%t:%m'
      lint-offset-columns: 1
      lint-category-map:
        I: H
        R: I
        C: I
        W: W
        E: E
        F: E

    vint-lint: &vint-lint
      prefix: vint
      lint-command: '${lib.getExe pkgs.vim-vint} --style-problem ''${INPUT}'
      lint-formats:
        - '%f:%l:%c: %m'

    yamllint-lint: &yamllint-lint
      prefix: yamllint
      lint-command: '${pkgs.yamllint}/bin/yamllint --strict --format parsable ''${INPUT}'
      lint-stdin: false
      lint-formats:
        - '%f:%l"%c: [%t%*[a-z]] %m'
      env:
        - 'PYTHONIOENCODING=UTF-8'

  languages:
    sh:
      - <<: *shfmt-format

    cmake:
      - <<: *gersemi-format

    git:
      - <<: *gitlint-lint

    json:
      - <<: *fixjson-format

    json5:
      - <<: *fixjson-format

    make:
      - <<: *checkmake-lint

    nix:
      - <<: *alejandra-format
      - <<: *statix-lint

    python:
      - <<: *black-action-format
      - <<: *flake8-lint
      - <<: *isort-format
      - <<: *pylint-lint

    vim:
      - <<: *vint-lint

    yaml:
      - <<: *yamllint-lint
''
