local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
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

-- Install your plugins here
return packer.startup(function(use)
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins

    -- auto complete
    -- 代码自动补全
    -- 自动补全单引号，双引号等
    use 'Raimondi/delimitMate'
    use 'andersevenrud/cmp-tmux'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- quick edit
    -- 快速注释
    use 'scrooloose/nerdcommenter'

    -- 快速加入修改环绕字符
    -- for repeat -> enhance surround.vim, . to repeat command
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'

    use 'ntpeters/vim-better-whitespace'

    -- quick movement
    -- easymotion
    -- 更高效的移动 [,, + w/fx/h/j/k/l]
    use 'Lokaltog/vim-easymotion'

    -- 更高效的行内移动, f/F/t/T, 才触发
    -- quickscope
    use 'unblevable/quick-scope'

    -- signature
    -- 显示marks - 方便自己进行标记和跳转
    -- m[a-zA-Z] add mark
    -- '[a-zA-Z] go to mark
    -- m<Space>  del all marks
    -- m/        list all marks
    -- m.        add new mark just follow previous mark
    use 'kshenoy/vim-signature'

    -- quick selection and edit
    -- 多光标选中编辑
    -- multiplecursors
    use 'mg979/vim-visual-multi'

    -- qf
    use 'kevinhwang91/nvim-bqf'

    use 'folke/which-key.nvim'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'glepnir/lspsaga.nvim'
    use 'simrat39/rust-tools.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- git
    -- fugitive
    use 'tpope/vim-fugitive'
    -- gitgutter
    use 'airblade/vim-gitgutter'

    -- gundo
    -- edit history, 可以查看回到某个历史状态
    use 'sjl/gundo.vim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'navarasu/onedark.nvim'
    use 'nvim-lua/lsp-status.nvim'

    -- nav
    -- ctrlspace
    use 'mhinz/vim-startify'
    -- tagbar
    use 'majutsushi/tagbar'
    use 'dstein64/nvim-scrollview'

    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'folke/trouble.nvim'

    -- tmux
    -- For tmux navigator Ctrl-hjkl
    use 'christoomey/vim-tmux-navigator'

    use 'ConradIrwin/vim-bracketed-paste'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-refactor' -- this provides "go to def--etc
    use 'folke/twilight.nvim'
    -- use 'romgrk/nvim-treesitter-context'

    use 'tjdevries/colorbuddy.vim'
    use 'tjdevries/gruvbuddy.nvim'

    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
