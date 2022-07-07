{ lib, ... }: {
  imports = [
    ./cmp
    ./dap
    ./lsp
    ./lualine
    ./misc
    ./neogit
    ./telescope
    ./theme
    ./treesitter
  ];
}
