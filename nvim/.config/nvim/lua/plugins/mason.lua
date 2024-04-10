return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "clangd",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "lemminx",
        "lua_ls",
        "pyright",
        "ruff_lsp",
        "rust_analyzer",
        "vimls",
        "yamlls",
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "ruff",
        -- "prettier",
        "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
      })
    end,
  },
}
