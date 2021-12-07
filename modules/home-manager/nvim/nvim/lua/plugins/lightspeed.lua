local M = {}

local setup = function()
  require("lightspeed").setup({
    jump_to_first_match = true,
    jump_on_partial_input_safety_timeout = 400,
    highlight_unique_chars = false,
    grey_out_search_area = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  })
end

M.use = function(use)
  use({
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = setup,
  })
end

return M
