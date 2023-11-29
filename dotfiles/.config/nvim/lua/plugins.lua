require("Comment").setup { mappings = false }
local comment = require "Comment.ft"
comment.beancount = ";%s"

require("nvim-surround").setup {}

local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" }, python = { "ruff" } }
local lint_group = vim.api.nvim_create_augroup("lint_group", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_group,
    callback = function() lint.try_lint() end,
})

-- stylua: ignore
require("nvim-treesitter.configs").setup {
    highlight = { enable = true,
        disable = { "python" },
        additional_vim_regex_highlighting = { "markdown" },
    },
    textobjects = { select = { enable = true,
        keymaps = {
            ["af"] = "@function.outer", ["if"] = "@function.inner",
            ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
            ["as"] = "@statement.outer",
        }
    }},
    incremental_selection = { enable = true,
        keymaps = {
            init_selection = "<tab>", scope_incremental = "<CR>",
            node_incremental = "<tab>", node_decremental = "<s-tab>",
        },
    },
}
require("treesitter-context").setup { patterns = { python = { "if", "elif" } } }

-- Language server configuration

require("neodev").setup {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require "lspconfig"
local function server(name, cfg)
    lspconfig[name].setup(
        vim.tbl_extend("error", cfg or {}, { capabilities = capabilities })
    )
end

-- vim.lsp.set_log_level "debug"
server "clangd"
server "nil_ls"

vim.g.neoformat_nasm_nasmfmt = { exe = "nasmfmt", replace = 1 }
vim.g.neoformat_enabled_nasm = { "nasmfmt" }
server("asm_lsp", { filetypes = { "nasm" } })

vim.g.neoformat_typst_typstfmt = { exe = "typstfmt", replace = 1 }
vim.g.neoformat_enabled_typst = { "typstfmt" }
server("typst_lsp", { settings = { experimentalFormatterMode = "on" } })

vim.g.neoformat_python_ruff = { exe = "ruff", args = { "format" }, replace = 1 }
vim.g.neoformat_enabled_python = { "ruff" }
server("pyright", {
    settings = { python = { analysis = { diagnosticMode = "openFilesOnly" } } },
})

server("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})
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
