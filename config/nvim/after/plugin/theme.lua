local auto_dark_mode = require("auto-dark-mode")
local catppuccin = require("catppuccin")
local catppuccin_config = require("catppuccin_config")

-- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-5287724
catppuccin.setup(catppuccin_config)

vim.cmd("colorscheme catppuccin")

-- auto_dark_mode.setup({
-- 	update_interval = 500,
-- 	set_dark_mode = function()
-- 		vim.api.nvim_set_option("background", "dark")
--     vim.cmd("colorscheme catppuccin")
-- 	end,
-- 	set_light_mode = function()
-- 		vim.api.nvim_set_option("background", "light")
--     vim.cmd("colorscheme catppuccin")
-- 	end,
-- })
