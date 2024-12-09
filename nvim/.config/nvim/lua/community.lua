-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.recipes.vscode" },
}
