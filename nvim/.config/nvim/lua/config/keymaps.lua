-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Preserve yank buffer when pasting over visual selection
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection without overwriting yank" })
