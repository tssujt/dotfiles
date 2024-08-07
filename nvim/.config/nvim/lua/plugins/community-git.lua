return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    event = "User AstroGitFile",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    config = function() require("neogit").setup {} end,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable "git" == 1,
    event = "User AstroGitFile",
    opts = function()
      local get_icon = require("astroui").get_icon
      return {
        signs = {
          add = { text = get_icon "GitSign" },
          change = { text = get_icon "GitSign" },
          delete = { text = get_icon "GitSign" },
          topdelete = { text = get_icon "GitSign" },
          changedelete = { text = get_icon "GitSign" },
          untracked = { text = get_icon "GitSign" },
        },
        worktrees = require("astrocore").config.git_worktrees,
      }
    end,
  },
  {
    "almo7aya/openingh.nvim",
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
  },
}
