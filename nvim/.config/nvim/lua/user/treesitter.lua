require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
        -- disable = { "c", "rust" }
    },
    indent = {enable = true, disable = {"yaml"}},
    autopairs = {enable = true},
    context_commentstring = {enable = true, enable_autocmd = false}
}
-- require'treesitter-context.config'.setup {enable = true}
require("twilight").setup {
    context = 10,
    treesitter = true,
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function", "method", "table", "if_statement"
    }
}
