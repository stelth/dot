{ lib, ... }: {
  imports = [
    ./cmp
    ./dap
    ./leap
    ./lsp
    ./lualine
    ./misc
    ./neogit
    ./telescope
    ./theme
    ./treesitter
  ];
}
