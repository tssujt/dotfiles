require('bufferline').setup {
    options = {
        mode = "tabs",
        offsets = {{filetype = "NvimTree", text = " Explorer", padding = 1}},
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        diagnostic = false,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = 'slant',
        always_show_bufferline = true
    }
}

require('close_buffers').setup({
    filetype_ignore = {}, -- Filetype to ignore when running deletions
    file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
    file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
    preserve_window_layout = {'this', 'nameless'}, -- Types of deletion that should preserve the window layout
    next_buffer_cmd = nil -- Custom function to retrieve the next buffer when preserving window layout
})
