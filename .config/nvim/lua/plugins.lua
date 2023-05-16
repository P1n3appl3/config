require("hop").setup()
require("nvim-surround").setup {}
require("Comment").setup { mappings = false }
require("auto-session").setup { auto_save_enabled = true, auto_restore_enabled = false }
require("fidget").setup { text = { spinner = "dots" } }
-- TODO: keybind or null-ls code action for hunk stage/diff
require("gitsigns").setup { keymaps = {}, current_line_blame_opts = { delay = 100 } }
-- stylua: ignore
require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true, disable = { "python" },
        additional_vim_regex_highlighting = false,
    },
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
vim.g.startuptime_exe_path = 'nvim'

-- language server configuration
local lspconfig = require "lspconfig"
local coq = require "coq"
local function server(name, cfg) lspconfig[name].setup(coq.lsp_ensure_capabilities(cfg)) end

server "clangd"
server "nil_ls"
server("pyright", {
    settings = { python = { analysis = { diagnosticMode = "openFilesOnly" } } },
})

require("neodev").setup {}
server("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})

local fuchsia = string.find(vim.loop.cwd() or "", "/fuchsia")
local fx_clippy = { overrideCommand = { "fx", "clippy", "--all", "--raw" } }
local ra_settings = {
    checkOnSave = fuchsia and fx_clippy or { command = "clippy" },
    cachePriming = { enable = false },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
}
require("rust-tools").setup(coq.lsp_ensure_capabilities {
    tools = { inlay_hints = { auto = false } },
    server = { settings = { ["rust-analyzer"] = ra_settings } },
})

-- non-lsp linters
local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" }, python = { "ruff" } }
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
