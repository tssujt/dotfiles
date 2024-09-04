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
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
    opts = {
      provider = "copilot",
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          both = "cb",
          next = "]x",
          prev = "[x",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle = {
          debug = "<leader>ad",
          hint = "<leader>ah",
        },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        symbol_map = { Copilot = "" },
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
              buffer = "[ Buf]",
              nvim_lsp = "[ LSP]",
              luasnip = "[ LSnip]",
              nvim_lua = "[ NvimLua]",
            },
          },
        },
        sources = {
          { name = "copilot", priority = 1000 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
        },
      })
    end,
  },
}
