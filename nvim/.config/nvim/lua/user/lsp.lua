local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then return end

local status_lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig_ok then return end

local cmp = require 'cmp'
local util = require 'lspconfig/util'

cmp.setup {
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
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
        }), { 'i', 'c' }),
            ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
        }), { 'i', 'c' }),
            ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
            ['<CR>'] = function(fallback) fallback() end,
            ['<C-e>'] = function(fallback) fallback() end
    },
    sources = {
        { name = 'nvim_lsp' }, {
        name = 'tmux',
        option = {
            all_panes = false,
            label = '[tmux]',
            trigger_characters = { '.' },
            trigger_characters_ft = {} -- { filetype = { '.' } }
        }
    }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'path' },
        { name = 'rg' }, { name = 'spell' }, { name = 'treesitter' }
    },
    experimental = { ghost_text = true },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    }
}
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {
            go = false,
            tex = false,
        }
    })
)

local nvim_status = require "lsp-status"

require("user.statusline").activate()

local updated_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
    .protocol
    .make_client_capabilities())
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities,
    nvim_status.capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport =
    false
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
}

vim.fn.sign_define("LspDiagnosticsSignError",
    { text = "", numhl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsSignWarning",
    { text = "", numhl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation",
    { text = "", numhl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint",
    { text = "", numhl = "LspDiagnosticsDefaultHint" })

local flake8 = {
    lintCommand =
    "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintSource = "flake8"
}

local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true,
}

local black = {
    formatCommand = "black --fast -",
    formatStdin = true,
}

local misspell = {
    lintCommand = "misspell",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintSource = "misspell"
}

require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "dockerls", "efm", "gopls", "html", "jsonls", "lemminx", "lua_ls",
        "pyright", "rust_analyzer", "vimls", "yamlls"
    }
})

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            capabilities = updated_capabilities
        };
        vim.cmd [[ do User LspAttachBuffers ]]
    end,
        ["efm"] = function()
        lspconfig.efm.setup {
            filetypes = { "python" },
            init_options = { documentFormatting = true },
            root_dir = vim.loop.cwd,
            settings = {
                rootMarkers = { ".git/" },
                languages = {
                        ["="] = { misspell },
                    python = { flake8, isort, black },
                }
            }
        }
    end,
        ["gopls"] = function()
        lspconfig.gopls.setup {
            cmd = { "gopls", "serve" },
            filetypes = { "go", "gomod" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        }
    end,
        ["pyright"] = function()
        lspconfig.pyright.setup {
            settings = { python = { analysis = { typeCheckingMode = "off" } } }
        }
    end,
        ["rust_analyzer"] = function()
        local opts = {
            tools = {
                autoSetHints = true,
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
                        checkOnSave = { command = "clippy" }
                    }
                }
            }
        }
        require("rust-tools").setup(opts)
    end,
        ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                    telemetry = {
                        enable = false,
                    },
                }
            }
        }
    end,
})

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
    code_action_keys = { quit = "q", exec = "<CR>" },
    rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
    rename_prompt_prefix = "➤"
}

require("trouble").setup {}
require "lsp_signature".setup()

-- vim.lsp.set_log_level("debug")
