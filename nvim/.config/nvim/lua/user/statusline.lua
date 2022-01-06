require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'moonfly',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {'quickfix', 'fugitive', 'nvim-tree'}
}

local nvim_status = require "lsp-status"

local status = {}

status.select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
        local value_range = {
            ["start"] = {
                character = 0,
                line = vim.fn.byte2line(symbol.valueRange[1])
            },
            ["end"] = {
                character = 0,
                line = vim.fn.byte2line(symbol.valueRange[2])
            }
        }

        return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
end

status.activate = function()
    nvim_status.config {
        select_symbol = status.select_symbol,

        indicator_errors = 'E',
        indicator_warnings = 'W',
        indicator_info = 'i',
        indicator_hint = '?',
        indicator_ok = 'Ok',
        spinner_frames = {
            "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"
        }
    }

    nvim_status.register_progress()
end

status.on_attach = function(client)
    nvim_status.on_attach(client)

    vim.cmd [[
      augroup MyLspStatusGroup
        autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()
      augroup END
    ]]
end

return status
