require("hop").setup()
require("nvim-surround").setup {}
require("Comment").setup { mappings = false }
require("auto-session").setup { auto_save_enabled = true, auto_restore_enabled = false }
require("fidget").setup { text = { spinner = "dots" } }
require("gitsigns").setup { keymaps = {}, current_line_blame_opts = { delay = 100 } }
-- stylua: ignore
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash", "c", "cpp", "python", "rust", "lua", "kdl", "json", "toml", "json",
	    "make", "ninja", "dot", "zig", "html", "css", "typescript", "javascript"
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    textobjects = { select = { enable = true,
        keymaps = {
            ["af"] = "@function.outer",  ["if"] = "@function.inner",
            ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",     ["ib"] = "@block.inner"}},
    },
}
require("treesitter-context").setup { patterns = { python = { "if", "elif" } } }
FZF = require "fzf-lua"
FZF.setup {
    preview_layout = "vertical",
    preview_vertical = "up",
    keymap = { fzf = { ["ctrl-u"] = "half-page-up", ["ctrl-d"] = "half-page-down" } },
    files = { fd_opts = "-Htf --mount --color always" },
    grep = { rg_opts = "-S. --no-heading --color always" },
}

-- language server configuration
require("neodev").setup {}
local lspconfig = require "lspconfig"
-- TODO: clang-tidy with user config, more file ext's, semantic highlighting
lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup {}
-- lspconfig.wgsl_analyzer.setup {}

local fuchsia = vim.startswith(vim.loop.cwd() or "", "/mnt/fuchsia")
local fx_clippy = { overrideCommand = { "fx", "clippy", "--all", "--raw" } }
local ra_settings = {
    checkOnSave = fuchsia and fx_clippy or { command = "clippy" },
    cachePriming = { enable = false },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
}
require("rust-tools").setup {
    tools = { inlay_hints = { auto = false } },
    server = { settings = { ["rust-analyzer"] = ra_settings } },
}

-- non-lsp linters
local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" } }
local lint_group = vim.api.nvim_create_augroup("lint_group", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_group,
    callback = function() lint.try_lint() end,
})

-- use system clipboard over ssh
if vim.env.SSH_TTY then
    local function copy(lines, _) require("osc52").copy(table.concat(lines, "\n")) end
    local function paste()
        return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" }
    end
    vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
    }
end
