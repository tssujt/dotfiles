return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "c",
      "comment",
      "commonlisp",
      "diff",
      "dockerfile",
      "go",
      "gomod",
      "gowork",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "json5",
      "lua",
      "python",
      "rust",
      "toml",
      "vim",
      "yaml",
    })
    opts.highlight = { enable = true, additional_vim_regex_highlighting = true }
    opts.indent = { enable = true, disable = { "yaml", "python" } }
    opts.autopairs = { enable = true }
    opts.context_commentstring = { enable = true, enable_autocmd = false }
  end,
}
