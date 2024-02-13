return {
  "melopilosyan/rspec-integrated.nvim",
  event = "VeryLazy",
  config = function()
    local opts = { silent = true, noremap = true }

    vim.keymap.set("n", "<leader>tI", "<cmd>lua require('rspec.integrated').run_spec_file()<cr>", opts)
    vim.keymap.set("n", "<leader>ti", "<cmd>lua require('rspec.integrated').run_spec_file({only_current_example = true})<cr>", opts)
    vim.keymap.set("n", "<leader>t.", "<cmd>lua require('rspec.integrated').run_spec_file({repeat_last_run = true})<cr>", opts)
  end
}
