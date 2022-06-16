local options = {
    autoindent = true,
    autoread = true,
    background = 'dark',
    backspace = "eol,start,indent",
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = {"menu", "menuone", "noselect"}, -- https://github.com/hrsh7th/nvim-cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    cursorcolumn = true,
    cursorline = true, -- highlight the current line
    encoding = "utf-8",
    expandtab = true, -- convert tabs to spaces
    exrc = true,
    ffs = "unix,dos,mac", -- Use Unix as the standard file type
    fileencoding = "utf-8", -- the encoding written to a file
    guifont = "monospace:h17", -- the font used in graphical neovim applications
    helplang = "cn",
    hidden = true, -- A buffer becomes hidden when it is abandoned
    hlsearch = true, -- highlight all matches on previous search pattern
    history = 2000,
    incsearch = true, -- 打开增量搜索模式,随着键入即时搜索
    ignorecase = true, -- ignore case in search patterns
    laststatus = 2, -- Always show the status line - use 2 lines for the status bar
    magic = true, -- For regular expressions turn magic on
    matchtime = 2, -- How many tenths of a second to blink when matching brackets
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pumheight = 10, -- pop up menu height
    relativenumber = false, -- set relative numbered lines
    ruler = true, -- 显示当前的行号列号
    scrolloff = 8, -- 在上下移动光标时，光标的上方或下方至少会保留显示的行数
    selection = 'inclusive',
    selectmode = "mouse,key",
    shiftround = true, -- 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showcmd = true, -- 在状态栏显示正在输入的命令
    showmode = true, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    showmatch = true, -- 括号配对情况, 跳转并高亮一下匹配的括号
    sidescrolloff = 8,
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    smarttab = true, -- insert tabs on the start of a line according to shiftwidth, not tabstop
    softtabstop = 4, -- 按退格键时可以一次删掉 4 个空格
    spell = true,
    spelllang = {"en", "cjk"},
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- insert 4 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- change the terminal's title
    tm = 500,
    ttyfast = true,
    updatetime = 300, -- faster completion (4000ms default)
    wildignore = "*.o,*.swp,*.bak,*.pyc,*.class,.svn",
    wildmenu = true, -- 增强模式中的命令行自动完成操作
    wildmode = "list:longest",
    wrap = true, -- display lines as one long line
    writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

-- Changed home directory here
local backup_dir = vim.fn.stdpath("cache") .. "/backup"
local backup_stat = pcall(os.execute, "mkdir -p " .. backup_dir)
if backup_stat then
    vim.opt.backupdir = backup_dir
    vim.opt.directory = backup_dir
end

local undo_dir = vim.fn.stdpath("cache") .. "/undo"
local undo_stat = pcall(os.execute, "mkdir -p " .. undo_dir)
local has_persist = vim.fn.has("persistent_undo")
if undo_stat and has_persist == 1 then
    vim.opt.undofile = true
    vim.opt.undodir = undo_dir
end

-- https://github.com/nvim-lua/completion-nvim#recommended-setting
vim.opt.shortmess:append "c"
vim.opt.formatoptions:append "m" -- 如遇 Unicode 值大于 255 的文本，不必等到空格再折行
vim.opt.formatoptions:append "B" -- 合并两行中文时，不在中间加空格

for k, v in pairs(options) do vim.opt[k] = v end

local default = require('kanagawa.colors').setup()
require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = {italic = true},
    functionStyle = {bold = true},
    keywordStyle = {italic = true},
    statementStyle = {bold = true},
    typeStyle = {bold = true},
    variablebuiltinStyle = {italic = true},
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    colors = {},
    overrides = {
        LazygitBackground = {bg = default.sumilnk3},
        FTermBackground = {bg = default.sumilnk3},
        htmlH1 = {fg = default.peachRed, bold = true},
        htmlH2 = {fg = default.roninYellow, bold = true},
        htmlH3 = {fg = default.autumnYellow, bold = true},
        htmlH4 = {fg = default.autumnGreen, bold = true},
        Todo = {fg = default.fujiWhite, bg = default.samuraiRed, bold = true},
        NormalFloat = {fg = default.fujiWhite, bg = default.winterBlue}
    }
})

vim.cmd "set mouse=nv"
vim.cmd "set nrformats=" -- 00x增减数字时使用十进制
vim.cmd "set t_ut=" -- 防止 tmux 下 vim 的背景色显示异常 http://sunaku.github.io/vim-256color-bce.html
vim.cmd "set t_vb=" -- 去掉输入错误的提示声音
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set viminfo^=%" -- Remember info about open buffers on closeRemember info about open buffers on close
vim.cmd [[set iskeyword+=-]]

vim.cmd [[colorscheme kanagawa]]
vim.cmd [[filetype plugin indent on]]

vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = vim.fn.expand('~/.pyenv/shims/python')
