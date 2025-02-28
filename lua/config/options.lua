vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
-- vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.cmd("set colorcolumn=80")
vim.cmd("set clipboard=unnamed")
vim.cmd("set splitbelow")
vim.cmd("set splitright")
vim.g.mapleader = " "
vim.opt.termguicolors = true

-- Remove trailing white spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Add borders to diagnostic float boxes
vim.diagnostic.config {
    float = { border = "rounded" },
}


-- Open nvim configuration
vim.api.nvim_create_user_command('Config', function()
    vim.cmd('edit ~/.config/nvim/')
end, {})

-- Open tmux configuration
vim.api.nvim_create_user_command('Tmux', function()
    vim.cmd('edit ~/.tmux/tmux.conf')
end, {})
