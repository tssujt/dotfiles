require("filetype").setup({
    overrides = {
        complex = {
            ["requirements.in"] = "requirements",
            ["requirements.txt"] = "requirements",
            ["conf/requirements/.*.txt"] = "requirements",
            ["conf/requirements/.*.in"] = "requirements",
            [".*git/config"] = "gitconfig"
        },
        literal = { [".env"] = "config" }
    }
})
