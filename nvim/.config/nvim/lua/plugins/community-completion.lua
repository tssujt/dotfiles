return {
  { import = "astrocommunity.completion.cmp-cmdline" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = true },
        panel = { enabled = false },
        filetypes = {
          yaml = true,
        },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    config = function() require("copilot_cmp").setup() end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
    },
    event = "VeryLazy",
  },
  {
    "Exafunction/codeium.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({})
    end
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        symbol_map = { Copilot = "", Codeium = "" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      return require("astrocore").extend_tbl(opts, {
        mapping = cmp.mapping.preset.insert {
          ["<C-y>"] = cmp.mapping.confirm { select = true },
          ["<C-a>"] = cmp.mapping.complete {
            config = {
              sources = {
                { name = "codeium" },
                { name = "copilot" },
              },
            },
          },
        },
        formatting = {
          format = require("lspkind").cmp_format {
            with_text = true,
            menu = {
              copilot = "[ Copilot]",
              codeium = "[ Codeium]",
              buffer = "[ Buf]",
              nvim_lsp = "[ LSP]",
              luasnip = "[ LSnip]",
              nvim_lua = "[ NvimLua]",
            },
          },
        },
        sources = {
          { name = "copilot", priority = 1000 },
          { name = "codeium", priority = 1000 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
        },
      })
    end,
  },
}
