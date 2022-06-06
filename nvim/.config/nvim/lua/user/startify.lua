function _G.webDevIcons(path)
    local filename = vim.fn.fnamemodify(path, ':t')
    local extension = vim.fn.fnamemodify(path, ':e')
    return require'nvim-web-devicons'.get_icon(filename, extension,
                                               {default = true})
end

vim.cmd [[
    function! StartifyEntryFormat() abort
        return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    endfunction
]]


local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  return
end

impatient.enable_profile()
