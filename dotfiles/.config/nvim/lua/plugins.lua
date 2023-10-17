-- General

require("fzf-lua").setup {
    preview_layout = "vertical",
    preview_vertical = "up",
    keymap = {
        fzf = { ["ctrl-u"] = "half-page-up", ["ctrl-d"] = "half-page-down" },
    },
    files = { fd_opts = "-Htf --mount --color always" },
    grep = { rg_opts = "-S. --no-heading --color always" },
}
require("hop").setup {}
require("auto-session").setup { auto_save_enabled = true, auto_restore_enabled = false }
vim.g.startuptime_exe_path = "nvim"
vim.o.timeoutlen = 300
require("which-key").setup {
    plugins = {
        presets = { operators = false, motions = false, text_objects = false },
    },
    layout = { width = { max = 40 } },
    triggers = { "g", "z", "<leader>", ",", "<c-w>", "<c-r>", '"', "'", "`" },
}
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

-- Programming

require("nvim-surround").setup {}
require("Comment").setup { mappings = false }
local comment = require "Comment.ft"
comment.beancount = ";%s" -- TODO: set in treesitter or upstream?

local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" }, python = { "ruff" } }
local lint_group = vim.api.nvim_create_augroup("lint_group", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_group,
    callback = function() lint.try_lint() end,
})

-- stylua: ignore
require "nvim-treesitter.configs".setup {
    highlight = { enable = true,
        disable = { "python" },
        additional_vim_regex_highlighting = true,
    },
    textobjects = {
        select = { enable = true,
            keymaps = {
                ["af"] = "@function.outer", ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
                ["as"] = "@statement.outer",
            },
        },
    },
    incremental_selection = { enable = true,
        keymaps = {
            init_selection = "<tab>",
            node_incremental = "<tab>",
            scope_incremental = "<CR>",
            node_decremental = "<s-tab>",
        },
    },
}
require("treesitter-context").setup { patterns = { python = { "if", "elif" } } }
-- TODO: figure out why this takes so long
require("treesj").setup { use_default_keymaps = false }

-- Language server configuration

require("neodev").setup {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require "lspconfig"
local function server(name, cfg)
    lspconfig[name].setup(
        vim.tbl_extend("error", cfg or {}, { capabilities = capabilities })
    )
end

server "clangd"
server "nil_ls"
server "asm_lsp"
server("pyright", {
    settings = { python = { analysis = { diagnosticMode = "openFilesOnly" } } },
})
server("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
server(
    "beancount",
    { init_options = { journal_file = vim.env.HOME .. "/money/journal.beancount" } }
)

local fuchsia = string.find(vim.loop.cwd() or "", "/fuchsia")
local fx_clippy = { overrideCommand = { "fx", "clippy", "--all", "--raw" } }
local ra_settings = {
    checkOnSave = fuchsia and fx_clippy or { command = "clippy" },
    cachePriming = { enable = false },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
    completion = { callable = { snippets = "none" }, postfix = { enable = false } },
}
require("rust-tools").setup {
    capabilities = capabilities,
    tools = { inlay_hints = { auto = false } },
    server = { settings = { ["rust-analyzer"] = ra_settings } },
}
