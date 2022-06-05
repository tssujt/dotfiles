local opts = {noremap = true, silent = true}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("", "<Left>", "", opts)
keymap("", "<Right>", "", opts)
keymap("", "<Up>", "", opts)
keymap("", "<Down>", "", opts)
keymap("", "<Space>", "<Nop>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-t>", ":tabnew<CR>", opts)

keymap("n", "/", "/\\v", opts)

keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)

-- Select block
keymap("n", "<leader>v", "V`}", opts)

-- 交换 ' `, 使得可以快速使用'跳到marked位置
keymap("n", "'", "`", opts)
keymap("n", "`", "'", opts)

-- Remap U to <C-r> for easier redo
keymap("n", "U", "<C-r>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "kj", "<ESC>", opts)
keymap("i", "<C-t>", "<ESC>:tabnew<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("v", "/", "/\\v", opts)

keymap("v", "<leader>y", '"+y', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("c", "<C-j>", "<t_kd>", opts)
keymap("c", "<C-k>", "<t_ku>", opts)
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-e>", "<End>", opts)
