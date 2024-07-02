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
    ["<Leader>/"] = false,
    ["<Leader>bd"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Close current buffer" },
    ["<Leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    ["<Leader>c"] = false,
    ["<Leader>C"] = false,
    ["<Leader>fl"] = { "<cmd>Neotree reveal reveal_force_cwd<cr>", desc = "Explorer Find File Location" },
    ["<Leader>fa"] = { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" },
    ["<Leader>fc"] = {
      function()
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          cwd = vim.fn.stdpath "config",
          follow = true,
        }
      end,
      desc = "Find AstroNvim config files",
    },
    ["<Leader>fN"] = { "<cmd>Telescope noice<cr>", desc = "Find noice" },
    ["<Leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    ["<Leader>fs"] = {
      function() require("sg.extensions.telescope").fuzzy_search_results() end,
      desc = "Find SourceGraph",
    },
    ["<Leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    ["<Leader>fw"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find words",
    },
    ["<Leader>fW"] = false,
    ["<Leader>gj"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    ["<Leader>gk"] = { function() require("gitsigns").previous_hunk() end, desc = "Previous Git hunk" },
    ["<Leader>tu"] = false,
    ["<Leader>U"] = { "<cmd>Telescope undo<cr>", desc = "Undo" },
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
    ["<Leader>/"] = false,
    ["<Leader>fr"] = {
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      desc = "Find code refactors",
    },
  },
}

-- refactoring
maps.n["<Leader>r"] = { desc = " Refactor" }
maps.v["<Leader>r"] = { desc = " Refactor" }

-- copilot
maps.n["<Leader>c"] = { name = " Copilot", desc = " Copilot" }
maps.n["<Leader>ch"] = {
  function()
    local actions = require "CopilotChat.actions"
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  end,
  desc = "CopilotChat - Help actions",
}
maps.n["<Leader>cp"] = {
  function()
    local actions = require "CopilotChat.actions"
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  end,
  desc = "CopilotChat - Prompt actions",
}
maps.n["<Leader>cr"] = { "<cmd>CopilotChatReset<cr>", desc = "Reset chat history and clear buffer" }

maps.v["<Leader>c"] = { name = " Copilot", desc = " Copilot" }
maps.v["<Leader>ce"] = { "<cmd>CopilotChatExplain<cr>", desc = "Explain code" }
maps.v["<Leader>ct"] = { "<cmd>CopilotChatTests<cr>", desc = "Generate tests" }
maps.v["<Leader>cT"] = { "<cmd>CopilotChatVsplitToggle<cr>", desc = "Toggle vertical split" }
maps.v["<Leader>cr"] = { "<cmd>CopilotChatReset<cr>", desc = "Reset chat history and clear buffer" }
maps.v["<Leader>cv"] = { "<cmd>CopilotChatVisual<cr>", desc = "Open in vertical split" }
maps.v["<Leader>cx"] = { "<cmd>CopilotChatInPlace<cr>", desc = "Run in-place code" }

-- trouble
maps.n["<Leader>x"] = { desc = " Trouble" }
maps.n["<Leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
maps.n["<Leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
maps.n["<Leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
maps.n["<Leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
maps.n["<Leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }

-- flash
maps.n["<Leader>s"] = {
  function() require("flash").jump() end,
  desc = "Flash",
}
maps.x["<Leader>s"] = {
  function() require("flash").jump() end,
  desc = "Flash",
}
maps.o["<Leader>s"] = {
  function() require("flash").jump() end,
  desc = "Flash",
}
maps.n["<Leader><Leader>s"] = {
  function() require("flash").treesitter() end,
  desc = "Flash Treesitter",
}
maps.x["<Leader><Leader>s"] = {
  function() require("flash").treesitter() end,
  desc = "Flash Treesitter",
}
maps.o["<Leader><Leader>s"] = {
  function() require("flash").treesitter() end,
  desc = "Flash Treesitter",
}

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
        skip_ts_context_commentstring_module = true,
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
            if require("astrocore").is_available("resession.nvim") then
              -- Only load the session if nvim was started with no args
              if vim.fn.argc(-1) == 0 then
                -- try to load a directory session using the current working directory
                require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
                -- trigger buffer read auto commands on each opened buffer after load
                vim.tbl_map(vim.cmd.doautoall, { "BufReadPre", "BufReadPost" })
              end
            end

          end,
        },
      },
    },
  },
}
