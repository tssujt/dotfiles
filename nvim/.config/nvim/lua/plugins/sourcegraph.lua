return {
  {
    "sourcegraph/sg.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() require("sg").setup {} end,
  },
}
