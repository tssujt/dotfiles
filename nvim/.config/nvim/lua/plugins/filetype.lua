return {
  { "raimon49/requirements.txt.vim", event = "BufEnter" },
  {
    "nathom/filetype.nvim",
    event = "BufEnter",
    config = function()
      require("filetype").setup {
        overrides = {
          complex = {
            ["requirements.in"] = "requirements",
            ["requirements.txt"] = "requirements",
            ["conf/requirements/.*.txt"] = "requirements",
            ["conf/requirements/.*.in"] = "requirements",
            [".*git/config"] = "gitconfig",
          },
          literal = { [".env"] = "config" },
        },
      }
    end,
  },
}
