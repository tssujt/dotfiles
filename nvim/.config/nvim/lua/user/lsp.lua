local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then return end

local cmp = require 'cmp'
cmp.setup {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = ({
                buffer = "[﬘ Buf]",
                nvim_lsp = "[ LSP]",
                luasnip = "[ LSnip]",
                nvim_lua = "[ NvimLua]",
                latex_symbols = "[ Latex]",
                rg = "[ RG]"
            })
        })
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert
        }), {'i', 'c'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
        }), {'i', 'c'}),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<CR>'] = function(fallback) fallback() end,
        ['<C-e>'] = function(fallback) fallback() end
    },
    sources = {
        {name = 'nvim_lsp'}, {
            name = 'tmux',
            option = {
                all_panes = false,
                label = '[tmux]',
                trigger_characters = {'.'},
                trigger_characters_ft = {} -- { filetype = { '.' } }
            }
        }, {name = 'luasnip'}, {name = 'buffer'}, {name = 'path'},
        {name = 'rg'}, {name = 'spell'}, {name = 'treesitter'}
    },
    experimental = {ghost_text = true},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    }
}
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

local nvim_status = require "lsp-status"

require("user.statusline").activate()

local updated_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                             .protocol
                                                                             .make_client_capabilities())
updated_capabilities.textDocument.codeLens = {dynamicRegistration = false}
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities,
                                           nvim_status.capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport =
    false
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

vim.fn.sign_define("LspDiagnosticsSignError",
                   {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {text = "", numhl = "LspDiagnosticsDefaultHint"})

local flake8 = {
    lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %t%n%n%n %m"},
    lintSource = "flake8"
}

local misspell = {
    lintCommand = "misspell",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintSource = "misspell"
}

local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local servers = {
    "bashls", "clangd", "dockerls", "efm", "gopls", "grammarly", "html",
    "jsonls", "lemminx", "pyright", "rust_analyzer", "sumneko_lua", "vimls",
    "yamlls"
}

for _, lang in pairs(servers) do
    local ok, server = lsp_installer.get_server(lang)
    if ok then
        if not server:is_installed() then
            print("Installing " .. lang)
            server:install()
        end
    end
end

lsp_installer.on_server_ready(function(server)
    local config = {capabilities = updated_capabilities}

    if server.name == "gopls" then config.filetypes = {"go"}; end
    if server.name == "sourcekit" then
        config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
    end
    if server.name == "clangd" then
        config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
    end
    if server.name == "efm" then
        config.filetypes = {"c", "cpp", "python", "lua"}
        config.init_options = {documentFormatting = true};
        config.root_dir = vim.loop.cwd;
        config.settings = {
            rootMarkers = {".git/"},
            languages = {
                ["="] = {misspell},
                python = {flake8},
                lua = {{formatCommand = "lua-format -i", formatStdin = true}}
            }
        }
    end
    if server.name == "sumneko_lua" then
        config.settings = {
            Lua = {
                diagnostics = {globals = {"vim"}},
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true
                    }
                }
            }
        }
    end
    if server.name == 'pyright' then
        config.settings = {python = {analysis = {typeCheckingMode = "off"}}}
    end

    server:setup(config)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

local saga = require 'lspsaga'
saga.init_lsp_saga()
saga.setup {
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>"
    },
    code_action_keys = {quit = "q", exec = "<CR>"},
    rename_action_keys = {quit = "<C-c>", exec = "<CR>"},
    rename_prompt_prefix = "➤"
}

require("trouble").setup {}
require"lsp_signature".setup()

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        -- runnables = {
        -- use_telescope = true
        -- },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = ""
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {command = "clippy"}
            }
        }
    }
}

require('rust-tools').setup(opts)
-- vim.lsp.set_log_level("debug")
