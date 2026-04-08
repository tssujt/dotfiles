return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"

      opts.sources = require("astrocore").list_insert_unique(opts.sources or {}, {
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.formatting.prettier.with {
          filetypes = { "html", "json", "jsonc", "markdown", "scss", "yaml" },
        },
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      handlers = {},
    },
  },
}
