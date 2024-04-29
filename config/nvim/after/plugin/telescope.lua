local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.load_extension("aerial")
telescope.load_extension("git_worktree")

telescope.setup({
	defaults = {
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    border = true,
		color_devicons = false,
    initial_mode = "insert",
    layout_config = {
      horizontal = {
        height = 0.9,
        preview_cuttoff = 0.8,
        prompt_position = "bottom",
        width = 0.8,
      },
      vertical = {
        height = 0.9,
        preview_cuttoff = 40,
        prompt_position = "bottom",
        width = 0.8,
      },
    },
    layout_strategy = "horizontal",
		prompt_prefix = "  ",
    sort_strategy = "ascending",

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
        ["<CR>"] = actions.select_default,
			},
		},
	},
  pickers = {
    live_grep = {
      file_ignore_patterns = {
        ".*/docs/.+",
        "^docs/.+",
        "Cargo.lock",
        "yarn.lock",
      },
    },
  },
})

local M = {}

function M.reload_modules()
	local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

local function refactor(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
	require("refactoring").refactor(content.value)
end

M.refactors = function()
	require("telescope.pickers").new({}, {
		prompt_title = "refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<CR>", refactor)
			map("n", "<CR>", refactor)
			return true
		end,
	}):find()
end

return M
