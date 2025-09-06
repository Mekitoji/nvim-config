-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
vim.o.timeoutlen = 300

-- close tab
vim.keymap.set("n", "gz", ":tabclose<CR>")

-- go to definition in new tab
vim.keymap.set("n", "gb", function()
  require("telescope.builtin").lsp_definitions({ jump_type = "tab" })
end, { desc = "Go to Definition (tab)" })
