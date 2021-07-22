require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true
        -- disable = { "c", "rust" }
    }
}
require'treesitter-context.config'.setup {enable = true}
