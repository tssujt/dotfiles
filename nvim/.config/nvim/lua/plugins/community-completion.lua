return {
    {import = "astrocommunity.completion.cmp-cmdline"},
    {"onsails/lspkind.nvim"}, {
        "hrsh7th/nvim-cmp",
        dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline"},
        opts = function(_, opts)
            local cmp = require "cmp"
            return require("astrocore").extend_tbl(opts, {
                mapping = cmp.mapping.preset.insert {
                    ["<C-y>"] = cmp.mapping.confirm {select = true}
                },
                formatting = {
                    format = require("lspkind").cmp_format {
                        with_text = true,
                        menu = {
                            buffer = "[ Buf]",
                            nvim_lsp = "[ LSP]",
                            nvim_lua = "[ NvimLua]"
                        }
                    }
                },
                sources = {
                    {name = "nvim_lsp", priority = 1000},
                    {name = "buffer", priority = 500}
                }
            })
        end
    }
}
