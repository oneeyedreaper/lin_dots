return {
	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
		},
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			{
				---@alias lc.lang
				---| "cpp"
				---| "java"
				---| "python"
				---| "python3"
				---| "c"
				---| "csharp"
				---| "javascript"
				---| "typescript"
				---| "php"
				---| "swift"
				---| "kotlin"
				---| "dart"
				---| "golang"
				---| "ruby"
				---| "scala"
				---| "rust"
				---| "racket"
				---| "erlang"
				---| "elixir"
				---| "bash"

				---@alias lc.hook
				---| "enter"
				---| "question_enter"
				---| "leave"

				---@alias lc.size
				---| string
				---| number
				---| { width: string | number, height: string | number }

				---@alias lc.position "top" | "right" | "bottom" | "left"

				---@alias lc.direction "col" | "row"

				---@alias lc.inject { before?: string|string[], after?: string|string[] }

				---@alias lc.storage table<"cache"|"home", string>

				---@class lc.UserConfig
				---@type string
				arg = "leetcode.nvim",

				---@type lc.lang
				lang = "cpp",

				cn = { -- leetcode.cn
					enabled = false, ---@type boolean
					translator = true, ---@type boolean
					translate_problems = true, ---@type boolean
				},

				---@type lc.storage
				storage = {
					home = vim.fn.stdpath("data") .. "/leetcode",
					cache = vim.fn.stdpath("cache") .. "/leetcode",
				},

				---@type table<string, boolean>
				plugins = {
					non_standalone = false,
				},

				---@type boolean
				logging = true,

				injector = {}, ---@type table<lc.lang, lc.inject>

				cache = {
					update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
				},

				console = {
					open_on_runcode = true, ---@type boolean

					dir = "row", ---@type lc.direction

					size = { ---@type lc.size
						width = "90%",
						height = "75%",
					},

					result = {
						size = "60%", ---@type lc.size
					},

					testcase = {
						virt_text = true, ---@type boolean

						size = "40%", ---@type lc.size
					},
				},

				description = {
					position = "left", ---@type lc.position

					width = "40%", ---@type lc.size

					show_stats = true, ---@type boolean
				},

				hooks = {
					---@type fun()[]
					["enter"] = {},

					---@type fun(question: lc.ui.Question)[]
					["question_enter"] = {},

					---@type fun()[]
					["leave"] = {},
				},

				keys = {
					toggle = { "q" }, ---@type string|string[]
					confirm = { "<CR>" }, ---@type string|string[]

					reset_testcases = "r", ---@type string
					use_testcase = "U", ---@type string
					focus_testcases = "H", ---@type string
					focus_result = "L", ---@type string
				},

				---@type lc.highlights
				theme = {},

				---@type boolean
				image_support = false,
			},
		},
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence"):setup({
				-- General options
				auto_update = true,
				neovim_image_text = "The One True Text Editor",
				main_image = "neovim",
				client_id = "793271441293967371",
				log_level = nil,
				debounce_timeout = 10,
				enable_line_number = false,
				blacklist = {},
				buttons = true,
				file_assets = {},

				-- Rich Presence text options
				editing_text = "Editing %s",
				file_explorer_text = "Browsing %s",
				git_commit_text = "Committing changes",
				plugin_manager_text = "Managing plugins",
				reading_text = "Reading %s",
				workspace_text = "Working on %s",
				line_number_text = "Line %s out of %s",
			})
		end,
	},

	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				-- type of hints you want to get
				-- following types are supported
				-- 'statusline-winbar' | 'floating-big-letter'
				-- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
				-- 'floating-big-letter' draw big letter on a floating window
				-- used
				hint = "floating-big-letter",

				-- when you go to window selection mode, status bar will show one of
				-- following letters on them so you can use that letter to select the window
				selection_chars = "FJDKSLA;CMRUEIWOQP",

				-- This section contains picker specific configurations
				picker_config = {
					statusline_winbar_picker = {
						-- You can change the display string in status bar.
						-- It supports '%' printf style. Such as `return char .. ': %f'` to display
						-- buffer file path. See :h 'stl' for details.
						selection_display = function(char, windowid)
							return "%=" .. char .. "%="
						end,

						-- whether you want to use winbar instead of the statusline
						-- "always" means to always use winbar,
						-- "never" means to never use winbar
						-- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
						use_winbar = "never", -- "always" | "never" | "smart"
					},

					floating_big_letter = {
						-- window picker plugin provides bunch of big letter fonts
						-- fonts will be lazy loaded as they are being requested
						-- additionally, user can pass in a table of fonts in to font
						-- property to use instead

						font = "ansi-shadow", -- ansi-shadow |
					},
				},

				-- whether to show 'Pick window:' prompt
				show_prompt = true,

				-- prompt message to show to get the user input
				prompt_message = "Pick window: ",

				-- if you want to manually filter out the windows, pass in a function that
				-- takes two parameters. You should return window ids that should be
				-- included in the selection
				-- EX:-
				-- function(window_ids, filters)
				--    -- folder the window_ids
				--    -- return only the ones you want to include
				--    return {1000, 1001}
				-- end
				filter_func = function(windows, rules)
					local function predicate(wid)
						cfg = vim.api.nvim_win_get_config(wid)
						if not cfg.focusable then
							return false
						end
						return true
					end
					local filtered = vim.tbl_filter(predicate, windows)

					local dfilter = require("window-picker.filters.default-window-filter"):new()
					dfilter:set_config(rules)
					return dfilter:filter_windows(filtered)
				end,

				-- following filters are only applied when you are using the default filter
				-- defined by this plugin. If you pass in a function to "filter_func"
				-- property, you are on your own
				filter_rules = {
					-- when there is only one window available to pick from, use that window
					-- without prompting the user to select
					autoselect_one = true,

					-- whether you want to include the window you are currently on to window
					-- selection or not
					include_current_win = false,

					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "NvimTree", "neo-tree", "notify" },

						-- if the file type is one of following, the window will be ignored
						buftype = { "terminal" },
					},

					-- filter using window options
					wo = {},

					-- if the file path contains one of following names, the window
					-- will be ignored
					file_path_contains = {},

					-- if the file name contains one of following names, the window will be
					-- ignored
					file_name_contains = {},
				},

				-- You can pass in the highlight name or a table of content to set as
				-- highlight
				highlights = {
					statusline = {
						focused = {
							fg = "#ededed",
							bg = "#e35e4f",
							bold = true,
						},
						unfocused = {
							fg = "#ededed",
							bg = "#44cc41",
							bold = true,
						},
					},
					winbar = {
						focused = {
							fg = "#ededed",
							bg = "#e35e4f",
							bold = true,
						},
						unfocused = {
							fg = "#ededed",
							bg = "#44cc41",
							bold = true,
						},
					},
				},
			})
		end,
	},
	{
		"telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = true,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser with the path of the current buffer",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				-- border = {},
				theme = "dropdown",
				-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "dropdown",
					initial_mode = "normal",
					-- layout_config = {
					-- preview_cutoff = 9999,
					-- },
				},
			}
			opts.extensions = {
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end,
	},
}
