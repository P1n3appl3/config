require("paq")({
	"savq/paq-nvim",

	-- navigation
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"lotabout/skim.vim",
	"phaazon/hop.nvim",
	-- "ggandor/lightspeed.nvim",

	-- visual
	"rktjmp/lush.nvim",
	"npxbr/gruvbox.nvim",
	"norcalli/nvim-colorizer.lua",
	"lewis6991/gitsigns.nvim",
	"kyazdani42/nvim-web-devicons",
	-- "romgrk/barbar.nvim",
	-- "akinsho/nvim-bufferline.lua",
	"folke/trouble.nvim",

	-- "itchyny/lightline.vim",
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",
	-- "famiu/feline.nvim",
	-- "ojroques/nvim-hardline",
	-- "hoob3rt/lualine.nvim",
	-- "glepnir/galaxyline.nvim",

	-- "folke/twilight.nvim",
	-- "edluffy/specs.nvim",
	-- "karb94/neoscroll.nvim",
	-- "p00f/nvim-ts-rainbow",

	-- programming
	"terrortylor/nvim-comment",
	"blackCauldron7/surround.nvim",
	"steelsojka/pears.nvim",
	-- "windwp/nvim-autopairs", -- TODO: compare
	"sbdchd/neoformat",
	-- "mhartington/formatter.nvim",
	"davidgranstrom/nvim-markdown-preview",
	-- "nvim-lua/completion-nvim",
	"hrsh7th/nvim-compe",
	"L3MON4D3/LuaSnip",
	"neovim/nvim-lspconfig",
	"simrat39/rust-tools.nvim",
	"folke/lua-dev.nvim",
	"simrat39/symbols-outline.nvim",
	-- "kosayoda/nvim-lightbulb",
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			vim.cmd("TSUpdate bash c cpp json lua python rust toml")
		end,
	},
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- "nvim-treesitter/nvim-treesitter-refactor",
	-- "lewis6991/spellsitter.nvim",
	"mfussenegger/nvim-dap", -- TODO: configure/test
})

local o = vim.opt
o.gdefault = true
o.hidden = true -- TODO: make sure i want this
o.ignorecase = true
o.smartcase = true
o.number = true
o.relativenumber = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.foldenable = false
o.backspace = { "indent", "eol", "start" }
o.inccommand = "split"
o.mouse = "a"
o.scrolloff = 7
o.updatetime = 500 -- TODO: only use if needed for hover
o.wildignore = { "*.o", "*.obj", "*.pyc" }
o.shortmess:append("c") -- TODO: make sure i want this

require("nvim_comment").setup()
vim.g.surround_mappings_style = "surround"
require("surround").setup({})
require("pears").setup(function(conf)
	conf.on_enter(function(pears_handle)
		if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
			return vim.fn["compe#confirm"]("<CR>")
		else
			pears_handle()
		end
	end)
end)
require("hop").setup()
require("gitsigns").setup({ keymaps = {} })
require("compe").setup({ enabled = true, source = { buffer = true, nvim_lsp = true } })
require("nvim-treesitter.configs").setup({
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	textobjects = {
		select = {
			enable = true,
			keymaps = { -- TODO: goto next arg
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
	},
	-- refactor = { highlight_definitions = { enable = true } },
})
require("trouble").setup({})
vim.g.symbols_outline = { highlight_hovered_item = false, show_guides = false, auto_preview = false }
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
require("rust-tools").setup({})
lspconfig.sumneko_lua.setup(require("lua-dev").setup({ lspconfig = { cmd = { "lua-language-server" } } }))
lspconfig.bashls.setup({})
-- lspconfig.diagnosticls.setup({})
lspconfig.jedi_language_server.setup({})
lspconfig.pyright.setup({})
lspconfig.racket_langserver.setup({})
lspconfig.svls.setup({})

vim.cmd([[ filetype plugin on ]]) -- TODO: test if this is needed
-- TODO: lua autocommands: https://github.com/neovim/neovim/pull/12378
vim.cmd([[autocmd TextYankPost * lua vim.highlight.on_yank {timeout=100, on_macro=true}]])
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

-- general mappings
local modemap = vim.api.nvim_set_keymap
local function map(lhs, rhs, opt)
	opt = opt or {}
	modemap("", lhs, rhs, opt)
end
modemap("n", "<Space>", "<NOP>", { noremap = true })
vim.g.mapleader = " "
map("<leader>qq", ":qa<CR>")
map("<leader>fs", ":w<CR>")
map("<leader>fS", ":wa<CR>")

-- search/replace
modemap("n", ",/", ":nohl<CR>", { silent = true })
modemap("n", "<C-_>", ":%s/", {})
modemap("v", "<C-_>", ":s/", {})

-- clipboard
map("Y", "y$")
map("<C-y>", '"+y')

-- movement
map("j", "gj")
map("k", "gk")
map("<C-j>", "<C-E>", { noremap = true })
map("<C-k>", "<C-Y>", { noremap = true })
map("s", ":HopChar2<CR>")
map("S", ":HopWord<CR>")

map("<leader>w", "<C-y>")
map("<leader>bd", ":bd<CR>")
map("<leader><tab>", ":b#<CR>")
map("<C-l>", ":bn<CR>", { silent = true })
-- map("<C-l>", ":BufferNext<CR>", { silent = true })
map("<C-h>", ":bp<CR>", { silent = true })
-- map("<C-h>", ":BufferPrevious<CR>", { silent = true })
-- map("<C-S-l>", ":BufferMoveNext<CR>", { silent = true })
-- map("<C-S-h>", ":BufferMovePrevious<CR>", { silent = true })
map("<leader>gn", ":lua require'gitsigns.actions'.next_hunk()<CR>")
map("<leader>gN", ":lua require'gitsigns.actions'.prev_hunk()<CR>")

-- completion
require("completion")
-- require("tab_complete")
-- modemap("i", "<C-Space>", "compe#complete()", { expr = true })
-- modemap("i", "<CR>", "compe#confirm()", { expr = true })
-- vim.cmd([[ inoremap <silent><expr> <C-Space> compe#complete() ]])
-- vim.cmd([[ inoremap <silent><expr> <CR>      compe#confirm('<CR>') ]])
-- modemap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
-- modemap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- programming
map("<leader>gb", ":lua require'gitsigns'.blame_line(true)<CR>")
map("<leader>c", "gc")
map(",=", ":Neoformat<CR>") -- TODO: lsp format
map("<leader>t", ":SymbolsOutline<CR>")
map("<leader>l", ":TroubleToggle<CR>")

map("gd", ":Telescope lsp_definitions<CR>")
-- map("gd", ":lua vim.lsp.buf.definition()<CR>")
map("gi", ":Telescope lsp_implementations<CR>")
-- map("gi", ":lua vim.lsp.buf.implementation()<CR>")
map("gr", ":Telescope lsp_references<CR>")
-- map("gr", ":lua vim.lsp.buf.references()<CR>")
-- map("<leader>a", ":Telescope lsp_code_actions<CR>")
map("<leader>a", ":lua vim.lsp.buf.code_action()<CR>")
map("<leader>f;", ":Telescope command_history<CR>")
map("<leader><leader>", ":Telescope commands<CR>")
-- map("<leader>ff", ":Telescope find_files<CR>")
map("<leader>ff", ":Files<CR>")
map("<leader>fF", ":Files ~<CR>")
map("<leader>f/", ":Files /<CR>")
-- map("<leader>bb", ":Telescope buffers<CR>")
map("<leader>bb", ":Buffers<CR>")
-- map("<leader>rg", ":Telescope live_grep<CR>")
map("<leader>rg", ":Rg<CR>")
-- map("<leader>fh", ":Telescope help_tags<CR>")
map("<leader>el", ":Telescope lsp_workspace_diagnostics<CR>")
map("<leader>cs", ":Telescope lsp_workspace_symbols<CR>")
map("<leader>cS", ":Telescope lsp_dynamic_workspace_symbols<CR>")

map("gD", ":lua vim.lsp.buf.declaration()<CR>")
map("gy", ":lua vim.lsp.buf.type_definition()<CR>")
map("K", ":lua vim.lsp.buf.hover()<CR>")
map("<C-S-k>", ":lua vim.lsp.buf.signature_help()<CR>")
map("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
map("<leader>ee", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map("<leader>en", ":lua vim.lsp.diagnostic.goto_next()<CR>")
map("<leader>eN", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
-- map("<leader>el", ":lua vim.lsp.diagnostic.set_loclist()<CR>") -- TODO: toggle
vim.cmd([[ command! LspFormat execute 'lua vim.lsp.buf.formatting()' ]])

-- Finder
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<esc>"] = actions.close,
			},
		},
	},
})

-- require("pretty")
vim.cmd([[ source $HOME/.config/nvim/pretty.vim ]])
