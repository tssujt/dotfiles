-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local uv = vim.uv or vim.loop

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local python3_host_prog = vim.env.NVIM_PYTHON3_HOST_PROG
if not python3_host_prog and vim.fn.executable "mise" == 1 then
  -- MISE_OFFLINE avoids remote version lookups that block startup for seconds
  local result = vim.system({ "mise", "which", "python3" }, { env = { MISE_OFFLINE = "1" }, text = true }):wait()
  if result.code == 0 then python3_host_prog = vim.trim(result.stdout) end
end
if not python3_host_prog or python3_host_prog == "" then python3_host_prog = vim.fn.exepath "python3" end
if python3_host_prog ~= "" and uv.fs_stat(python3_host_prog) then vim.g.python3_host_prog = python3_host_prog end

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
