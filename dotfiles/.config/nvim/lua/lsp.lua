local capabilities = require("cmp_nvim_lsp").default_capabilities()
local cfg = vim.lsp.config
-- TODO: migrate
-- local function server(name, cfg)
--     vim.lsp.config(
--         name,
--         vim.tbl_extend("error", cfg or {}, { capabilities = capabilities })
--     )
-- end

for _, server in ipairs {
    "clangd",
    "nil_ls",
    "tinymist",
    "fish_lsp",
    "asm_lsp",
    "pyright",
    "lua_ls",
} do
    vim.lsp.enable(server)
end

-- vim.lsp.set_log_level "debug"
cfg("tinymist", { settings = { exportPdf = "onSave" }, single_file_support = true })

vim.g.neoformat_nasm_nasmfmt = { exe = "nasmfmt", replace = 1 }
vim.g.neoformat_enabled_nasm = { "nasmfmt" }
cfg("asm_lsp", { filetypes = { "nasm" } })

vim.g.neoformat_enabled_javascript = { "biome" }

vim.g.neoformat_enabled_python = { "ruff" }
cfg("pyright", {
    settings = { python = { analysis = { diagnosticMode = "openFilesOnly" } } },
})

cfg("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})

local ra_settings = {
    cachePriming = { enable = false },
    diagnostics = {
        diagnostics = {
            disabled = {
                "unresolved-proc-macro",
                "inactive-code",
            },
        },
        disabled = {
            "unresolved-proc-macro",
            "inactive-code",
        },
    },
    completion = { callable = { snippets = "none" }, postfix = { enable = false } },
    cargo = { cfgs = { "miri" } },
}
local ra_log = vim.fn.tempname() .. "-rust-analyzer.log"
cfg("rust-analyzer", {
    capabilities = capabilities,
    -- files = exclude_dirs = {}
    tools = { inlay_hints = { auto = false } },
    server = { default_settings = { ["rust-analyzer"] = ra_settings }, logfile = ra_log },
})
