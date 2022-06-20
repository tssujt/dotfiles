local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- auto complete
    use 'andersevenrud/cmp-tmux'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'f3fora/cmp-spell'
    use 'lukas-reineke/cmp-rg'
    use 'ray-x/cmp-treesitter'
    use {'hrsh7th/nvim-cmp', requires = {'onsails/lspkind-nvim'}}
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use {
        "zbirenbaum/copilot.lua",
        after = 'bufferline.nvim',
        config = function()
            vim.defer_fn(function() require("copilot").setup() end, 100)
        end
    }
    use {"zbirenbaum/copilot-cmp", after = {"copilot.lua", "nvim-cmp"}}

    -- speed up neovim!
    use 'nathom/filetype.nvim'
    use {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = 'cd app && yarn install'
    }

    use 'raimon49/requirements.txt.vim'

    use 'antoinemadec/FixCursorHold.nvim'

    use 'numToStr/Comment.nvim'

    -- 快速加入修改环绕字符
    -- for repeat -> enhance surround.vim, . to repeat command
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'

    use 'windwp/nvim-autopairs'

    use 'ntpeters/vim-better-whitespace'

    -- quick movement
    -- easymotion
    -- 更高效的移动 [,, + w/fx/h/j/k/l]
    use 'Lokaltog/vim-easymotion'

    -- 更高效的行内移动, f/F/t/T, 才触发
    -- quickscope
    use 'unblevable/quick-scope'
    -- Switch between single-line and multiline forms of code
    use 'AndrewRadev/splitjoin.vim'

    -- signature
    -- 显示marks - 方便自己进行标记和跳转
    -- m[a-zA-Z] add mark
    -- '[a-zA-Z] go to mark
    -- m<Space>  del all marks
    -- m/        list all marks
    -- m.        add new mark just follow previous mark
    use 'kshenoy/vim-signature'

    -- quick selection and edit
    -- multiplecursors
    use 'mg979/vim-visual-multi'

    -- qf
    use 'kevinhwang91/nvim-bqf'

    use 'folke/which-key.nvim'

    -- lsp status progess
    use 'nvim-lua/lsp-status.nvim'
    use 'arkav/lualine-lsp-progress'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'tami5/lspsaga.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'simrat39/rust-tools.nvim'

    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-telescope/telescope-live-grep-args.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'ahmedkhalf/project.nvim'
    use "Shatur/neovim-session-manager"
    use "ethanholz/nvim-lastplace" -- auto return back to the last modified position when open a file

    use 'lambdalisue/suda.vim'

    -- git
    use 'lewis6991/gitsigns.nvim'
    use {'TimUntersberger/neogit'}

    -- terminal
    use "akinsho/toggleterm.nvim"

    -- undo tree visualizer
    use "simnalamburt/vim-mundo"

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'danymat/neogen'

    -- nav
    use 'mhinz/vim-startify'
    -- tagbar
    use 'simrat39/symbols-outline.nvim'

    -- scrollbar
    use 'lewis6991/satellite.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use 'kazhala/close-buffers.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'folke/trouble.nvim'
    use {
        "beauwilliams/focus.nvim",
        config = function() require("focus").setup() end
    }

    -- tmux
    -- For tmux navigator Ctrl-hjkl
    use 'christoomey/vim-tmux-navigator'

    use 'ConradIrwin/vim-bracketed-paste'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'nvim-treesitter/nvim-treesitter-refactor' -- this provides "go to def--etc
    use 'folke/twilight.nvim'
    -- use 'romgrk/nvim-treesitter-context'

    use "rebelot/kanagawa.nvim"

    -- Speed up loading Lua modules
    use "lewis6991/impatient.nvim"
    use 'dstein64/vim-startuptime'

    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
