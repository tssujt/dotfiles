require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "c", "comment", "commonlisp", "dockerfile", "go", "gomod",
        "gowork", "html", "http", "java", "javascript", "json", "json5", "lua",
        "python", "rust", "toml", "vim", "yaml"
    },
    highlight = { enable = true, additional_vim_regex_highlighting = true },
    indent = { enable = true, disable = { "yaml", "python" } },
    autopairs = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false }
}
-- require'treesitter-context.config'.setup {enable = true}
require("twilight").setup {
    context = 10,
    treesitter = true,
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function", "method", "table", "if_statement"
    }
}
