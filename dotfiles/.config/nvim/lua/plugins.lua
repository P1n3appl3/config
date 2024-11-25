require("Comment").setup { mappings = false }
local comment = require "Comment.ft"
comment.beancount = ";%s"
comment.gn = "#%s"

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

-- Language specific configuration

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
server("tinymist", { settings = { exportPdf = "onSave" }, single_file_support = true })

vim.g.neoformat_nasm_nasmfmt = { exe = "nasmfmt", replace = 1 }
vim.g.neoformat_enabled_nasm = { "nasmfmt" }
server("asm_lsp", { filetypes = { "nasm" } })

vim.g.neoformat_enabled_javascript = { "biome" }

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

local ra_settings = {
    cachePriming = { enable = false },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
    completion = { callable = { snippets = "none" }, postfix = { enable = false } },
}
local ra_log = vim.fn.tempname() .. "-rust-analyzer.log"
vim.g.rustaceanvim = {
    capabilities = capabilities,
    tools = { inlay_hints = { auto = false } },
    server = {
        default_settings = { ["rust-analyzer"] = ra_settings },
        logfile = ra_log,
        cmd = function()
            local fuchsia = string.find(vim.loop.cwd() or "", "fuchsia")
            local fx_ra = "/mnt/fuchsia/prebuilt/third_party/rust-analyzer/rust-analyzer"
            local binary = fuchsia and fx_ra or "rust-analyzer"
            return { binary, "--log-file", ra_log }
        end,
    },
}
