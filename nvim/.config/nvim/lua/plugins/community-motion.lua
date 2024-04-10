return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      continue = true,
      modes = {
        search = {
          enabled = false,
        },
        char = {
          jump_labels = true,
          keys = { "f", "F", "t", "T" },
        },
      },
      label = {
        rainbow = {
          enabled = true,
        },
      },
    },
    keys = {},
  },
}
