local opts = {noremap = true, silent = true}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>gc", ":Git commit<CR>", opts)
keymap("n", "<leader>ge", ":Git diff<CR>", opts)
keymap("n", "<leader>gl", ":Git log<CR>", opts)
keymap("n", "<leader>gs", ":Git<CR>", opts)

keymap("n", "<leader>hu", ":GitGutterUndoHunk<CR>", opts)
keymap("n", "<leader>hp", ":GitGutterPreviewHunk<CR>", opts)
keymap("n", "<leader>hj", ":GitGutterPrevHunk<CR>", opts)
keymap("n", "<leader>hk", ":GitGutterNextHunk<CR>", opts)

vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_enabled = 1
vim.g.gitgutter_highlight_lines = 1
