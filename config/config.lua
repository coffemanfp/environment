-- commands install:
--  :LvimCacheReset
--  :PackerSync

-- only if you need it:
--  :GoInstallBinaries
--  :GoUpdateBinaries
--  npm install -g eslint
--  npm install -g prettier
--  npm install -g tree-sitter-cli
--  npm install -g emmet-ls
--  npm install -g bash-language-server
--  pip install black

---- core plugins activation
lvim.builtin.terminal.active = false
lvim.builtin.which_key.active = false
lvim.builtin.project.active = false
lvim.builtin.notify.active = true

---- extra plugins install
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{ "tpope/vim-repeat" },
	{ "fatih/vim-go" },
	{ "rust-lang/rust.vim" },
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" }
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function ()
			require"lsp_signature".setup({
				always_trigger = true,
				hint_prefix = "🦊 ",
				doc_lines = 0,
			})
		end
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				names = true, -- "Name" codes like Blue
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "alpha", "Dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit"
		},
		ft = {"fugitive"}
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	}
}

---- general vim config
lvim.leader = "space"

vim.opt.shell = "/bin/sh"
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = ""
vim.opt.guifont = "Cascadia Code PL:h11"
vim.opt.clipboard = ""
vim.opt.mouse = ""
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.colorcolumn = "99999"
vim.opt.conceallevel = 0
vim.g.vim_json_conceal = 0
vim.g.vim_json_syntax_conceal = 0
vim.opt.fileencoding = "utf-8"
vim.opt.updatetime = 300
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.numberwidth = 1
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.swapfile = true
vim.opt.directory = vim.fn.stdpath "cache" .. "/swap"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.hidden = true
vim.opt.signcolumn = "auto"
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.whichwrap = ""
vim.opt.spell = false
vim.opt.spelllang = ""
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.o.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- colorscheme theme
vim.g.tokyonight_style = "night"
lvim.colorscheme = "tokyonight"

vim.cmd [[
autocmd ColorScheme * highlight VertSplit guibg=#16161E

match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#292e42
autocmd FileType alpha,Dashboard highlight ExtraWhitespace ctermbg=none guibg=none
autocmd BufWinLeave * call clearmatches()
]]

---- mapping keys
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>e"] = ":NvimTreeFindFileToggle<cr>"
lvim.keys.normal_mode["<leader>n"] = ":NvimTreeToggle<cr>"
lvim.keys.normal_mode["<leader>f"] = ":lua require('telescope.builtin').find_files()<cr>"
lvim.keys.normal_mode["<leader>j"] = ":lua require('telescope.builtin').live_grep()<cr>"
lvim.keys.normal_mode["<leader>b"] = ":lua require('telescope.builtin').buffers()<cr>"

lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>"
lvim.keys.normal_mode["ga"] = "<cmd>lua vim.lsp.buf.type_definition()<CR>"
lvim.keys.normal_mode["gi"] = "<cmd>lua vim.lsp.buf.implementation()<CR>"
lvim.keys.normal_mode["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>"
lvim.keys.normal_mode["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>"
lvim.keys.normal_mode["<leader>rn"] = "<cmd>lua vim.lsp.buf.rename()<CR>"
lvim.keys.normal_mode["<leader>q"] = "<cmd>lua vim.lsp.buf.code_action()<CR>"

lvim.keys.normal_mode["<leader>l"] = "<cmd>lua vim.diagnostic.setloclist()<CR>"
lvim.keys.normal_mode["g["] = "<cmd>lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["g]"] = "<cmd>lua vim.diagnostic.goto_next()<CR>"

vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>gj :GoBuild<CR>")
vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>gk :GoVet<CR>")
vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>gl :GoLint<CR>")
vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>gat :GoAddTags<CR>")
vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>grt :GoRemoveTags<CR>")
vim.api.nvim_command("autocmd FileType go nmap <buffer> <leader>gcp :GoChannelPeers<CR>")

---- core plugins config

-- null-ls config
local nullLs = require "null-ls"
local nullLsUtils = require "null-ls.utils"
local nullLsClient = require('null-ls.client')
nullLs.setup({
	root_dir = nullLsUtils.root_pattern(
	".null-ls-root",
	"Makefile",
	".git",

	"go.mod",
	"go.work",
	".vim/",
	".hg/"
	),
})

-- increase timeout to 2 seconds
vim.lsp.buf.formatting_sync(nil, 2000)

-- formatters config
local nullLsFormatters = require "lvim.lsp.null-ls.formatters"
nullLsFormatters.setup {
	{ exe = "shfmt" },
	{ exe = "asmfmt" },
	{ exe = "black" },
	{
		exe = "prettier",
		args = {
			"--config-precedence", "file-override",
			"--use-tabs",
			"--tab-width", "4",
			"--print-width", "100",
			"--arrow-parens", "avoid",
			"--bracket-same-line",
		},
		filetypes = {
			"html",
			"css",
			"scss",
			"less",

			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",

			"json",
			"yaml",
		},
	},
}

-- linters config
local nullLsLinters = require "lvim.lsp.null-ls.linters"
nullLsLinters.setup {
	{ exe = "golangci-lint" },
	{ exe = "eslint" },
	{ exe = "shellcheck" },
}

-- disable shellcheck in *.env files
vim.api.nvim_command("autocmd BufNewFile,BufRead *.env setfiletype env")

-- FuncGoReloadLinter reloads the linter if you are not inside the root_dir
local firstGoFile = true
function FuncLinterGoRestart()
	local ok = vim.api.nvim_buf_get_name(0):find(nullLsUtils.get_root(), 1, true) == 1

	if not ok or firstGoFile then
		firstGoFile = false
		vim.cmd("LinterRestart")
	end
end
vim.api.nvim_command("autocmd FileType go lua FuncLinterGoRestart()")

function FuncLinterStop()
	if nullLsClient.get_client() ~= nil then
		nullLsClient.get_client().stop()
	end
end
function FuncLinterEnable()
	nullLs.enable("")
end
function FuncLinterDisable()
	nullLs.disable("")
end

-- gitsigns config
lvim.builtin.gitsigns.opts.signs.delete.text = "▎"

-- nvimtree config
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.view.auto_resize = true
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.filters.custom = {
	".git",
	".pyc",
	"__pycache__",
}

local tree_cb = require "nvim-tree.config".nvim_tree_callback
lvim.builtin.nvimtree.setup.view.mappings.list = {
	{ key = "v", cb = tree_cb("vsplit") },
	{ key = "s", cb = tree_cb("split") },
	{ key = "t", cb = tree_cb("tabnew") },
	{ key = "x", cb = tree_cb("close_node") },
}

-- treesitter config
lvim.builtin.treesitter.indent = false
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"regex",
	"rust",
	"java",
	"php",
	"make",
	"cpp",
	"c",

	"bash",
	"dockerfile",

	"html",
	"css",
	"scss",

	"javascript",
	"tsx",
	"typescript",

	"markdown",

	"vim",
	"lua",

	"json",
	"yaml",

	"go",
	"gomod",
}

-- alpha/dashboard config
lvim.builtin.alpha.dashboard.section.buttons.entries = {
	{ "i", "✍️  New File", "<CMD>ene!<CR>i" },
	{ "e", "✏  File Explorer", "<CMD>ene!<CR><CMD>NvimTreeOpen<CR>" },
	{ "o", "✒  Open X Folder", "<CMD>silent exec '!xdg-open .'<CR>" },
	{ "f", "✉  Find File", "<CMD>ene!<CR><CMD>Telescope find_files<CR>" },
	{ "w", "  Find Word", "<CMD>ene!<CR><CMD>Telescope live_grep<CR>" },
	{ "u", "  Recently Used Files" , "<CMD>ene!<CR><CMD>Telescope oldfiles<CR>" },
	{ "s", "❤️  Checkhealth", "<CMD>checkhealth<CR>" },
	{ "c", "  Configuration", "<CMD>edit ~/.config/lvim/config.lua<CR>" },
	{ "q", "❌ Exit", "<CMD>q<CR>" },
}

lvim.builtin.alpha.dashboard.section.footer.val = {}

lvim.builtin.alpha.dashboard.section.header.val = {
	"                                            /\\   /\\   Hi! 🦊, " .. vim.fn.expand("$USER"),
	"                                           //\\\\_//\\\\     ____",
	"                                           \\_     _/    /   /",
	"                                            / * * \\    /^^^]",
	"                                            \\_\\O/_/    [   ]",
	"                                             /   \\_    [   /",
	"                                             \\     \\_  /  /",
	"                                              [ [ /  \\/ _/",
	"                                             _[ [ \\  /_/",
	"██╗     ██╗   ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"██║     ██║   ██║████╗  ██║██╔══██╗██╔══██╗██║   ██║██║████╗ ████║",
	"██║     ██║   ██║██╔██╗ ██║███████║██████╔╝██║   ██║██║██╔████╔██║",
	"██║     ██║   ██║██║╚██╗██║██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
	"███████╗╚██████╔╝██║ ╚████║██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
	"╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

-- lsp config
lvim.lsp.automatic_servers_installation = true
require("lvim.lsp.manager").setup("emmet_ls")
vim.list_extend(lvim.lsp.override, { "rust_analyzer" })

-- lualine config
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.sections.lualine_b = { components.branch, components.diff }
lvim.builtin.lualine.sections.lualine_c = {
	{
		"filename",
		path = 1,

		symbols = {
			modified = " [●]",
			readonly = " [🔒️]",
			unnamed = " [No Name]",
		}
	}
}
lvim.builtin.lualine.sections.lualine_x = { components.lsp, components.diagnostics }
lvim.builtin.lualine.sections.lualine_y = { "filetype" }
lvim.builtin.lualine.sections.lualine_z = { "progress" }

-- telescope config
lvim.builtin.telescope.defaults.prompt_prefix = "🔍 "
lvim.builtin.telescope.defaults.vimgrep_arguments = {
	"rg",
	"--color=never",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
	"--hidden",
	"-g", "!package-lock.json",
	"-g", "!go.sum",
	"-g", "!node_modules",
	"-g", "!.git",
}

lvim.builtin.telescope.defaults.mappings = {
	n = {
		["q"] = require("telescope.actions").close,
		["<Esc>"] = require("telescope.actions").close,
		["t"] = require("telescope.actions").select_tab,
		["v"] = require("telescope.actions").select_vertical,
		["s"] = require("telescope.actions").select_horizontal,
		["<C-d>"] = require("telescope.actions").delete_buffer
	},
	i = {
		["<C-t>"] = require("telescope.actions").select_tab,
		["<C-v>"] = require("telescope.actions").select_vertical,
		["<C-s>"] = require("telescope.actions").select_horizontal,
		["<C-d>"] = require("telescope.actions").delete_buffer
	},
}

-- bufferline config
lvim.builtin.bufferline.options.buffer_close_icon = ""
lvim.builtin.bufferline.options.close_icon = ""
lvim.builtin.bufferline.options.diagnostics_indicator = function(count, level)
	local icon

	if level:match("error") then
		icon = " "
	elseif level:match("warning") then
		icon = " "
	else
		icon = " "
	end

	return "" .. icon .. count
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<S-p>", ":BufferLinePick<CR>", opts)
map("n", "<C-h>", ":BufferLineMovePrev<CR>", opts)
map("n", "<C-l>", ":BufferLineMoveNext<CR>", opts)
map("n", "<C-c>", ":BufferKill<CR>", opts)

map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opts)

---- extra plugins config/setup

-- vim-go config
vim.g.go_fmt_command = ""
vim.g.go_fmt_autosave = 0
vim.g.go_mod_fmt_autosave = 0
vim.g.go_asmfmt_autosave = 0
vim.g.go_metalinter_autosave = 0

vim.g.go_addtags_transform = "camelcase"
vim.g.go_auto_type_info = 1
vim.g.go_jump_to_error = 0
vim.g.go_auto_sameids = 0
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_term_enabled = 1

---- commands
vim.cmd [[
command! Bo silent! execute "%bd|e#|bd#"

command! Cpath silent! execute "!pwd | xclip -selection clipboard"

command! SearchWhitespace silent! /\s\+$

command! LinterStop execute "lua FuncLinterStop()"
command! LinterDisable execute "lua FuncLinterDisable()"
command! LinterEnable execute "lua FuncLinterEnable()"
command! LinterRestart execute "lua require('null-ls.client')._reset()" | edit
]]

--
--
--

---- load custom configuration
local customConfig = vim.fn.glob("~/.lunarvim.lua")
if vim.fn.empty(customConfig) == 0 then
	loadfile(customConfig)()
end
