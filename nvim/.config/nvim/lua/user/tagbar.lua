vim.api.nvim_set_keymap("", "<F9>", ":TagbarToggle<CR>", {silent = true})

vim.g.tagbar_autofocus = 1
vim.g.tagbar_autoshowtag = 1
vim.g.tagbar_show_visibility = 1
-- for ruby
vim.g.tagbar_type_ruby = {
    kinds = {
        'm:modules',
        'c:classes',
        'd:describes',
        'C:contexts',
        'f:methods',
        'F:singleton methods',
    }
}
