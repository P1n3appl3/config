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
server("tinymist", {
    settings = { exportPdf = "onSave" },
    single_file_support = true,
    -- TODO: remove when fixed: https://github.com/Myriad-Dreamin/tinymist/issues/638
    offset_encoding = "utf-8",
})

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
    diagnostics = { disabled = {
        "unresolved-proc-macro",
        "inactive-code"
    } },
    completion = { callable = { snippets = "none" }, postfix = { enable = false } },
    cargo = { cfgs = { miri = "true" } },
}
local ra_log = vim.fn.tempname() .. "-rust-analyzer.log"
vim.g.rustaceanvim = {
    capabilities = capabilities,
    tools = { inlay_hints = { auto = false } },
    server = { default_settings = { ["rust-analyzer"] = ra_settings }, logfile = ra_log },
}
