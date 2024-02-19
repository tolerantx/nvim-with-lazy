-- Move to split
vim.keymap.set("n", "<M-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<M-Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<M-Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<M-Right>", ":wincmd l<CR>")

-- Tabs
vim.keymap.set("n", "<C-t><C-t>", ":tabnew<CR>")
vim.keymap.set({ "v", "i" }, "<C-t><C-t>", "<ESC>:tabnew<CR>")

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<ESC>:w<CR>:echo 'Saved!'<CR>")

-- Copy current path file
vim.keymap.set("n", "<leader>pl", ':let @*=fnamemodify(expand("%"), ":~:.") . ":" . line(".")<CR>:echo "File path:line copied!"<CR>')
vim.keymap.set("n", "<leader>pf", ':let @*=fnamemodify(expand("%"), ":~:.")<CR>:echo "File path copied!"<CR>')

-- Copy current path directory
vim.keymap.set("n", "<leader>pd", ':let @*=fnamemodify(expand("%:h"), ":~:.")<CR>:echo "Directory path copied!"<CR>')

-- Copy current file name
vim.keymap.set("n", "<leader>fn", ':let @*=expand("%:t")<CR>:echo "File name copied!"<CR>')

-- Reset search results using "/"
vim.keymap.set("n", "<ESC><ESC>", ":noh<CR>")

-- Don't copy to clipboard using C, c, S or s on normal mode
vim.keymap.set("n", "C", "\"_C", { noremap = true })
vim.keymap.set("n", "c", "\"_c", { noremap = true })
vim.keymap.set("n", "S", "\"_S", { noremap = true })
vim.keymap.set("n", "s", "\"_s", { noremap = true })
