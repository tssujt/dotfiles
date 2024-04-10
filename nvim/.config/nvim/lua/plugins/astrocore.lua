local utils = require "astrocore"
local is_available = utils.is_available

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local maps = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["]g"] = false,
    ["[g"] = false,
    ["<leader>/"] = false,
    ["<leader>bd"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Close current buffer" },
    ["<leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(
          function(bufnr) require("astrocore.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>c"] = false,
    ["<leader>C"] = false,
    ["<leader>fl"] = { "<cmd>Neotree reveal reveal_force_cwd<cr>", desc = "Explorer Find File Location" },
    ["<leader>fa"] = { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" },
    ["<leader>fc"] = {
      function()
        local cwd = vim.fn.stdpath "config" .. "/.."
        local search_dirs = {}
        for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
          if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
          if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
        end
        if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
          utils.notify("No user configuration files found", vim.log.levels.WARN)
        else
          if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
          require("telescope.builtin").find_files {
            prompt_title = "Config Files",
            search_dirs = search_dirs,
            cwd = cwd,
          } -- call telescope
        end
      end,
      desc = "Find AstroNvim config files",
    },
    ["<leader>fN"] = { "<cmd>Telescope noice<cr>", desc = "Find noice" },
    ["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    ["<leader>fs"] = {
      function() require("sg.extensions.telescope").fuzzy_search_results() end,
      desc = "Find SourceGraph",
    },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    ["<leader>fw"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find words",
    },
    ["<leader>fW"] = false,
    ["<leader>gj"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    ["<leader>gk"] = { function() require("gitsigns").previous_hunk() end, desc = "Previous Git hunk" },
    ["<leader>tu"] = false,
    ["<leader>U"] = { "<cmd>Telescope undo<cr>", desc = "Undo" },
    ["<TAB>"] = {
      function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-TAB>"] = {
      function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {},
  x = {},
  o = {},
  v = {
    ["<leader>/"] = false,
    ["<leader>fr"] = {
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      desc = "Find code refactors",
    },
  },
}

if is_available "vim-visual-multi" then
  -- visual multi
  vim.g.VM_mouse_mappings = 0
  vim.g.VM_theme = "iceblue"
  vim.g.VM_maps = {
    ["Find Under"] = "<C-n>",
    ["Find Subword Under"] = "<C-n>",
    ["Add Cursor Up"] = "<C-S-k>",
    ["Add Cursor Down"] = "<C-S-j>",
    ["Select All"] = "<C-S-n>",
    ["Skip Region"] = "<C-x>",
    Exit = "<C-c>",
  }
end

-- refactoring
if is_available "refactoring.nvim" then
  maps.n["<leader>r"] = { desc = " Refactor" }
  maps.v["<leader>r"] = { desc = " Refactor" }
end

-- copilot
if is_available "CopilotChat.nvim" then
  maps.n["<leader>c"] = { name = " Copilot", desc = " Copilot" }
  maps.n["<leader>ch"] = {
    function()
      local actions = require "CopilotChat.actions"
      require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    end,
    desc = "CopilotChat - Help actions",
  }
  maps.n["<leader>cp"] = {
    function()
      local actions = require "CopilotChat.actions"
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end,
    desc = "CopilotChat - Prompt actions",
  }
  maps.n["<leader>cr"] = { "<cmd>CopilotChatReset<cr>", desc = "Reset chat history and clear buffer" }

  maps.v["<leader>c"] = { name = " Copilot", desc = " Copilot" }
  maps.v["<leader>ce"] = { "<cmd>CopilotChatExplain<cr>", desc = "Explain code" }
  maps.v["<leader>ct"] = { "<cmd>CopilotChatTests<cr>", desc = "Generate tests" }
  maps.v["<leader>cT"] = { "<cmd>CopilotChatVsplitToggle<cr>", desc = "Toggle vertical split" }
  maps.v["<leader>cr"] = { "<cmd>CopilotChatReset<cr>", desc = "Reset chat history and clear buffer" }
  maps.v["<leader>cv"] = { "<cmd>CopilotChatVisual<cr>", desc = "Open in vertical split" }
  maps.v["<leader>cx"] = { "<cmd>CopilotChatInPlace<cr>", desc = "Run in-place code" }
end

-- trouble
if is_available "trouble.nvim" then
  maps.n["<leader>x"] = { desc = " Trouble" }
  maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
  maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
  maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
  maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
  maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }
end

-- flash
if is_available "flash.nvim" then
  maps.n["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.x["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.o["<leader>s"] = {
    function() require("flash").jump() end,
    desc = "Flash",
  }
  maps.n["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
  maps.x["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
  maps.o["<leader><leader>s"] = {
    function() require("flash").treesitter() end,
    desc = "Flash Treesitter",
  }
end

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        background = "dark",
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        spell = true, -- sets vim.opt.spell
        -- spellfile = vim.fn.expand "~/.config/nvim/lua/user/spell/en.utf-8.add",
        swapfile = false,
        wrap = false, -- sets vim.opt.wrap
      },
      g = {
        mapleader = ",", -- sets vim.g.mapleader
        strip_whitespace_on_save = true,
        VM_mouse_mappings = 0,
        VM_theme = "iceblue",
        VM_maps = {
          ["Find Under"] = "<C-n>",
          ["Find Subword Under"] = "<C-n>",
          ["Add Cursor Up"] = "<C-S-k>",
          ["Add Cursor Down"] = "<C-S-j>",
          ["Select All"] = "<C-S-n>",
          ["Skip Region"] = "<C-x>",
          Exit = "<C-c>",
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = maps,
    -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(
                vim.fn.getcwd(),
                { dir = "dirsession", silence_errors = true }
              )
              -- trigger buffer read auto commands on each opened buffer after load
              vim.tbl_map(vim.cmd.doautoall, { "BufReadPre", "BufReadPost" })
            end
          end,
        },
      },
    },
  },
}
