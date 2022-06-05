local Path = require('plenary.path')

require('session_manager').setup({
    sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
    path_replacer = '__', -- The character to which the path separator will be replaced for session files.
    colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit'
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80 -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

vim.cmd([[
  augroup _open_nvim_tree
    autocmd! * <buffer>
    autocmd SessionLoadPost * silent! lua require("nvim-tree").toggle(false, true)
  augroup end
]])

local status_ok, nvim_lastplace = pcall(require, "nvim-lastplace")
if not status_ok then
  vim.notify("nvim_lastplace not found!")
	return
end

nvim_lastplace.setup({
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
  }
)
