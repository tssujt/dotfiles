return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-project.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
          },
          n = { q = actions.close },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
        },
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
        },
      },
    })
  end,
  config = function(...)
    -- require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "fzf"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "noice"
    telescope.load_extension "project"
    telescope.load_extension "refactoring"
    telescope.load_extension "undo"
  end,
}
