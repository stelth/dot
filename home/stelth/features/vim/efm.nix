{
  lib,
  pkgs,
  ...
}: ''
  version: 2
  root-markers:
    - .git/

  tools:
    sh-shellcheck: &sh-shellcheck
      lint-command: '${lib.getExe pkgs.shellcheck} -f gcc -x -'
      prefix: shellcheck
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

    cpplint: &cpplint
      lint-command: 'cpplint'
      prefix: cpplint
      lint-stdin: false
      lint-ignore-exit-code: true
      lint-formats:
        - '%.%#.%l: %m'

    gitlint: &gitlint
      lint-command: '${lib.getExe pkgs.gitlint}'
      prefix: gitlint
      lint-stdin: true
      lint-formats:
        - '%l: %m: "%r"'
        - '%l: %m'

    dprint: &dprint
      format-command: '${lib.getExe pkgs.dprint}'
      format-stdin: true

    hadolint: &hadolint
      prefix: 'hadolint'
      lint-command: '${lib.getExe pkgs.hadolint}'
      lint-formats:
        - '%f:%l %m'

    google-java-format: &google-java-format
      format-command: '${lib.getExe pkgs.google-java-format} -'
      format-stdin: true

    fixjson: &fixjson
      format-command: '${lib.getExe pkgs.nodePackages.fixjson}'
      format-stdin: true

    jsonlint: &jsonlint
      prefix: jsonlint
      lint-command: '${lib.getExe pkgs.nodePackages.jsonlint} -c'
      lint-stdin: true
      lint-formats:
        - 'line %l, col %c, found: %m'

    checkmake: &checkmake
      prefix: checkmake
      lint-command: '${lib.getExe pkgs.checkmake} --format="{{.LineNumber}}:{{.Violation}}{{\"\n\"}}" ''${INPUT}'
      lint-stdin: false
      lint-formats:
        - '%l:%m'

    write-good: &write-good
      prefix: write-good
      lint-command: '${lib.getExe pkgs.nodePackages.write-good} --parse ''${INPUT}'
      lint-stdin: false
      lint-formats:
        - '%f:%l:%c:%m'

    alejandra: &alejandra
      format-command: '${lib.getExe pkgs.alejandra} --quiet'
      format-stdin: true

    statix: &statix
      prefix: statix
      lint-command: '${lib.getExe pkgs.statix} check --stdin --format=errfmt'
      lint-stdin: true
      lint-ignore-exit-code: true
      lint-formats:
        - '<stdin>>%l:%c:%t:%m'


    black: &black
      format-command: '${lib.getExe pkgs.python3Packages.black} --quiet -'
      format-stdin: true

    flake8: &flake8
      prefix: flake8
      lint-command: '${lib.getExe pkgs.python3Packages.flake8} --stdin-display-name ''${INPUT} -'
      lint-stdin: true
      lint-formats:
        - '%f:%l:%c: %m'

    isort: &isort
      format-command: '${lib.getExe pkgs.python3Packages.isort} --quiet -'
      format-stdin: true

    pylint: &pylint
      prefix: pylint
      lint-command: 'pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ''${INPUT}'
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

    vint: &vint
      prefix: vint
      lint-command: '${lib.getExe pkgs.vim-vint} -'
      lint-stdin: true
      lint-formats:
        - '%f:%l:%c: %m'

    yamllint: &yamllint
      prefix: yamllint
      lint-command: '${lib.getExe pkgs.yamllint} --strict --format parsable ''${INPUT}'
      lint-stdin: false
      lint-formats:
        - '%f:%l:%c: [%t%*[a-z]] %m'
      env:
        - 'PYTHONENCODING=UTF-8'

  languages:
    sh:
      - <<: *sh-shellcheck
      - <<: *sh-shfmt
    c:
      - <<: *clang-format
      - <<: *cpplint
    cpp:
      - <<: *clang-format
      - <<: *cpplint
    dockerfile:
      - <<: *dprint
      - <<: *hadolint
    gitcommit:
      - <<: *gitlint
    java:
      - <<: *google-java-format
    json:
      - <<: *fixjson
      - <<: *jsonlint
    json5:
      - <<: *fixjson
      - <<: *jsonlint
    make:
      - <<: *checkmake
    markdown:
      - <<: *write-good
    nix:
      - <<: *alejandra
      - <<: *statix
    python:
      - <<: *black
      - <<: *flake8
      - <<: *isort
      - <<: *pylint
    vim:
      - <<: *vint
    yaml:
      - <<: *yamllint
''
