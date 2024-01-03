{...}: ''
  vim.g.mapleader = ' '
  vim.o.timeout = true
  vim.o.timeoutlen = 300

  local telescope_builtin = require("telescope.builtin")

  local wk = require('which-key')

  wk.setup({})

  wk.register({
    -- Git keymaps
    g = {
      name = "git",
      c = { telescope_builtin.git_commits, "Commits" },
      b = { telescope_builtin.git_branches, "Branches" },
      s = { telescope_builtin.git_status, "Status" },
    },
    -- Help keymaps
    h = {
      name = "help",
      t = { telescope_builtin.builtin, "Telescope" },
      c = { telescope_builtin.commands, "Commands" },
      h = { telescope_builtin.help_tags, "Help Pages" },
      m = { telescope_builtin.man_pages, "Man Pages" },
      k = { telescope_builtin.keymaps, "Keymaps" },
      s = { telescope_builtin.highlights, "Search Highligh Groups" },
      l = { vim.show_pos, "Highlight Groups At Cursor" },
      f = { telescope_builtin.filetypes, "Filetypes" },
      o = { telescope_builtin.vim_options, "Vim Options" },
      a = { telescope_builtin.autocommands, "Autocommands" },
    },
    -- Search keymaps
    s = {
      name = "search",
      g = { telescope_builtin.live_grep, "Grep" },
      b = { telescope_builtin.current_buffer_fuzzy_find, "Buffer" },
      h = { telescope_builtin.command_history, "Command History" },
      m = { telescope_builtin.marks, "Marks" },
      w = { function()
        telescope_builtin.grep_string({ search = vim.fn.expand("<cword>") })
      end, "Current Word" },
    },
    f = {
      f = { telescope_builtin.find_files, "Find Files" },
      r = { telescope_builtin.oldfiles, "Recent Files" },
    },
    -- Switch buffer
    [","] = { function()
      telescope_builtin.buffers({ show_all_buffers = true })
    end, "Switch Buffer" },
    -- Quick Search
    ["/"] = { telescope_builtin.live_grep, "Search" },
    -- Undo navigation
    u = { require('telescope').extensions.undo.undo, "Undo" },
    -- Trouble
    t = {
      name = "trouble",
      t = { require('trouble').toggle, "Toggle" },
      n = { function()
        require("trouble").next({skip_groups = true, jump = true})
      end, "Next" },
      p = { function()
        require("trouble").previous({skip_groups = true, jump = true})
      end, "Previous" },
    },
  }, { prefix = "<leader>" })

  -- non-leader mappings
  wk.register({
    -- hlslens
    n = { [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], "Search Next" },
    N = { [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], "Search Prev" },
    ["*"] = { [[*<Cmd>lua require('hlslens').start()<CR>]], "Search Forwards" },
    ["#"] = { [[#<Cmd>lua require('hlslens').start()<CR>]], "Search Backwards" },
    ["g*"] = { [[g*<Cmd>lua require('hlslens').start()<CR>]], "Go Forwards" },
    ["g#"] = { [[g#<Cmd>lua require('hlslens').start()<CR>]], "Go Backwards" },
    ["<BS>"] = { [[<cmd>noh<CR>]], ""},
  })

  -- visual mode mappings
  wk.register({
     -- Move selection
    J = { [[:m '>+1<CR>gv=gv]], "Move Down" },
    K = { [[:m '<-2<CR>gv=gv]], "Move Up" },
  }, { mode = "v" })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local opts = { buffer = ev.buf }
      wk.register({
        c = {
          name = "code",
          a = { vim.lsp.buf.code_action, "Code Action" },
          f = { function()
              M.format(vim.api.nvim_get_current_buf())
            end, "Format" },
          d = { vim.diagnostic.open_float, "Line Diagnostics" },
          l = {
            name = "LSP",
            i = { vim.cmd.LspInfo, "Lsp Info" },
            a = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
            r = { vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
            l = { vim.lsp.buf.list_workspace_folders, "List Workspace Folders" },
          },
          r = { vim.lsp.buf.rename, "Rename" },
        },
        xd = { telescope_builtin.diagnostics, "Search Diagnostics" },
        tf = { M.toggle_formatting, "Toggle Formatting" },
        gd = { telescope_builtin.lsp_definitions, "Goto Definition" },
        gr = { telescope_builtin.lsp_references, "References" },
        gs = { vim.lsp.buf.signature_help, "Signature Help" },
        gI = { telescope_builtin.lsp_implementations, "Goto Implementation" },
        gt = { telescope_builtin.lsp_type_definitions, "Goto Type Definition" },
        K = { vim.lsp.buf.hover, "" },
      }, opts)
    end,
  })
''
