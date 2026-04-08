return {
    {import = "astrocommunity.completion.cmp-cmdline"}, {
        "zbirenbaum/copilot.lua",
        lazy = false,
        cmd = "Copilot",
        event = "User AstroFile",
        config = function()
            local auth = require "copilot.auth"
            local api = require "copilot.api"
            local client = require "copilot.client"
            local health = require "copilot.health"
            local health_check = health.check

            health.check = function()
                local is_authenticated = auth.is_authenticated
                auth.is_authenticated = function(callback)
                    vim.wait(3000, function() return client.initialized end, 100)
                    local copilot_client = client.get()
                    if copilot_client and client.initialized then
                        local done, authenticated = false, false
                        api.check_status(copilot_client, {}, function(err, status)
                            authenticated = not err and status and status.user ~= nil
                            done = true
                            if callback then callback(err) end
                        end)
                        vim.wait(3000, function() return done end, 100)
                        if done then return authenticated end
                    end
                    return is_authenticated(callback)
                end
                local ok, err = pcall(health_check)
                auth.is_authenticated = is_authenticated
                if not ok then error(err) end
            end
            require("copilot.client.config").add_callback(function()
                auth.is_authenticated()
            end)
            require("copilot").setup {
                suggestion = {enabled = true},
                panel = {enabled = false},
                filetypes = {yaml = true}
            }
            require("copilot.client").ensure_client_started()
        end
    }, {
        "zbirenbaum/copilot-cmp",
        dependencies = {"zbirenbaum/copilot.lua"},
        config = function() require("copilot_cmp").setup() end
    },
    {
        "onsails/lspkind.nvim",
        opts = function(_, opts)
            return require("astrocore").extend_tbl(opts, {
                symbol_map = {Copilot = ""}
            })
        end
    }, {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline",
            "zbirenbaum/copilot-cmp"
        },
        opts = function(_, opts)
            local cmp = require "cmp"
            return require("astrocore").extend_tbl(opts, {
                mapping = cmp.mapping.preset.insert {
                    ["<C-y>"] = cmp.mapping.confirm {select = true},
                    ["<C-a>"] = cmp.mapping.complete {
                        config = {sources = {{name = "copilot"}}}
                    }
                },
                formatting = {
                    format = require("lspkind").cmp_format {
                        with_text = true,
                        menu = {
                            copilot = "[ Copilot]",
                            buffer = "[ Buf]",
                            nvim_lsp = "[ LSP]",
                            nvim_lua = "[ NvimLua]"
                        }
                    }
                },
                sources = {
                    {name = "copilot", priority = 1000},
                    {name = "nvim_lsp", priority = 1000},
                    {name = "buffer", priority = 500}
                }
            })
        end
    }
}
