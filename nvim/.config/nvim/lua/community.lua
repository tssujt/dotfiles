-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.recipes.vscode" },
}
