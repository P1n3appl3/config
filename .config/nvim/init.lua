require "paq" {
    -- general
    "savq/paq-nvim",
    "vijaymarupudi/nvim-fzf",
    "ibhagwan/fzf-lua", -- TODO: vim-clap?
    "phaazon/hop.nvim",
    "jbyuki/instant.nvim",
    "dstein64/vim-startuptime",
    "nvim-lua/plenary.nvim",
    "rmagatti/auto-session",
    -- TODO: toggleterm

    -- appearance
    "rktjmp/lush.nvim",
    "norcalli/nvim-colorizer.lua",
    "lewis6991/gitsigns.nvim",
    "kyazdani42/nvim-web-devicons",
    "davidgranstrom/nvim-markdown-preview",

    -- programming
    "terrortylor/nvim-comment",
    "ur4ltz/surround.nvim",
    "windwp/nvim-autopairs",
    "sbdchd/neoformat", -- TODO: nvim-format and use lsp when available
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    "j-hui/fidget.nvim",
    "simrat39/rust-tools.nvim",
    "folke/lua-dev.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd "TSUpdate bash c cpp json lua python rust toml"
        end,
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "mfussenegger/nvim-dap", -- TODO: configure for rust/c/python/lua
}

-- general options
local o = vim.opt
o.gdefault = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.lazyredraw = true
o.number = true
o.relativenumber = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.foldenable = false
o.updatetime = 500
o.backspace = { "indent", "eol", "start" }
o.mouse = "a"
o.scrolloff = 7
o.wildignore = { "*.o", "*.obj", "*.pyc" }
o.shortmess:append "c"

-- my other configs
vim.cmd [[colorscheme custom]]
require "pretty"
require "completion"

-- plugin options
require("nvim_comment").setup()
vim.g.surround_mappings_style = "surround"
require("surround").setup {}
require("hop").setup()
require("auto-session").setup { auto_save_enabled = true, auto_restore_enabled = false }
require("fidget").setup { text = { spinner = "dots" } }
require("gitsigns").setup { keymaps = {}, current_line_blame_opts = { delay = 100 } }
require("nvim-treesitter.configs").setup {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
        },
    },
}
FZF = require "fzf-lua"
FZF.setup {
    fzf_bin = "sk",
    preview_layout = "vertical",
    preview_vertical = "up",
    keymap = { fzf = { ["ctrl-u"] = "half-page-up", ["ctrl-d"] = "half-page-down" } },
    files = { fd_opts = "-Htf --one-file-system" },
    grep = { rg_opts = "-S. --no-heading --color always" },
}

-- language server configuration
local lspconfig = require "lspconfig"
require("rust-tools").setup {
    -- TODO: https://github.com/simrat39/rust-tools.nvim/issues/163
    tools = { inlay_hints = { only_current_line = true } },
    server = {
        settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
    },
}
lspconfig.clangd.setup {} -- TODO: clang-tidy with user config, more file ext's
lspconfig.pyright.setup {}
lspconfig.sumneko_lua.setup(require("lua-dev").setup {})

-- non-lsp linters
local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" } }
local lint_group = vim.api.nvim_create_augroup("lint_group", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_group,
    callback = function()
        lint.try_lint()
    end,
})

-- global language client settings
vim.lsp.set_log_level "debug"
vim.diagnostic.config { virtual_text = false }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { signs = true, underline = true, update_in_insert = false }
)

-- general mappings
local modemap = vim.api.nvim_set_keymap
local function map(lhs, rhs, opt)
    opt = opt or {}
    modemap("", lhs, rhs, opt)
end
vim.g.mapleader = " "
modemap("n", "<space>", "<NOP>", { noremap = true })
map("<space>qq", ":qa<CR>")
map("<space>fs", ":w<CR>")
map("<space>fS", ":wa<CR>")
map("<space>w", "<C-w>")
map("<space>d", ":bd<CR>")
map("<space><tab>", ":b#<CR>")
-- toggleterm with <A-t>
-- modemap("t", "jk", "<C-\\><C-n>", { silent = true })
modemap("t", "<A-esc>", "<C-\\><C-n>", { silent = true })

-- search/replace
modemap("n", ",/", ":nohl<CR>", { silent = true })
modemap("n", "<C-_>", ":%s/", {})
modemap("v", "<C-_>", ":s/", {})

-- system clipboard
map("<C-y>", '"+y')
map("<C-p>", '"+p')

-- movement
map("j", "gj")
map("k", "gk")
map("<C-j>", "<C-E>", { noremap = true })
map("<C-k>", "<C-Y>", { noremap = true })
map("s", "<cmd>HopChar2<CR>")
map("S", "<cmd>HopWord<CR>")

-- programming
map("<space>gb", ":Gitsigns toggle_current_line_blame<CR>")
map("<space>c", "gc")
map(",=", ":Neoformat<CR>") -- TODO: LspFormat once the ecosystem gets there
vim.api.nvim_create_user_command("LspFormat", function()
    vim.lsp.buf.formatting()
end, {})
map("K", ":lua vim.lsp.buf.hover()<CR>")
map("<space>;", ":lua vim.lsp.buf.signature_help()<CR>")
map("<space>rn", ":lua vim.lsp.buf.rename()<CR>")
map("<space>ee", ":lua vim.diagnostic.open_float()<CR>")
map("<space>en", ":lua vim.diagnostic.goto_next()<CR>")
map("<space>eN", ":lua vim.diagnostic.goto_prev()<CR>")
map("<space>gn", ":lua require'gitsigns.actions'.next_hunk()<CR>")
map("<space>gN", ":lua require'gitsigns.actions'.prev_hunk()<CR>")

-- fuzzy finder
map("gd", ":lua FZF.lsp_definitions({ jump_to_single_result = true })<CR>")
map("gi", ":lua FZF.lsp_implementations({ jump_to_single_result = true })<CR>")
map("gr", ":lua FZF.lsp_references({ jump_to_single_result = true })<CR>")
map("gD", ":lua FZF.lsp_declarations({ jump_to_single_result = true })<CR>")
map("gt", ":lua vim.lsp.buf.type_definition()<CR>")
map("<space>t", ":FzfLua lsp_document_symbols<CR>")
map("<space>T", ":FzfLua lsp_workspace_symbols<CR>")
map("<space>el", ":FzfLua lsp_document_diagnostics<CR>")
map("<space>eL", ":FzfLua lsp_workspace_diagnostics<CR>")
map("<space>ca", ":FzfLua lsp_code_actions<CR>")
map("<space>qf", ":FzfLua quickfix<CR>")
map("<space>:", ":FzfLua command_history<CR>")
map("<space><space>", ":FzfLua commands<CR>")
map("<space>F", ":FzfLua files<CR>")
map("<space>ff", ":FzfLua files cwd=~<CR>")
map("<space>f/", ":FzfLua files cwd=/<CR>")
map("<space>fh", ":FzfLua oldfiles<CR>")
map("<space>fG", ":FzfLua git_files<CR>")
map("<space>fg", ":FzfLua git_status<CR>")
map("<space>b", ":FzfLua buffers<CR>")
map("<space>/", ":FzfLua search_history<CR>")
map("<space>rg", ":FzfLua live_grep_native<CR>")
map("<space>h", ":FzfLua help_tags<CR>")
map("<space>s", ":FzfLua spell_suggest<CR>")

-- Debug
function _G.put(...)
    local objects = {}
    for i = 1, select("#", ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end
    print(table.concat(objects, "\n"))
    return ...
end
vim.api.nvim_create_user_command("Reload", "so $MYVIMRC", {})
