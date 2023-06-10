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
require("hover").setup {
    init = function()
        require "hover.providers.lsp"
        require "hover.providers.man"
    end,
    preview_window = true,
    title = false,
    preview_opts = { border = "none" },
}

-- Appearance

require("colorizer").setup { user_default_options = { names = false } }
require("gitsigns").setup { keymaps = {}, current_line_blame_opts = { delay = 500 } }
require("dressing").setup {}
-- TODO: click to dismiss
local notify = require "notify"
notify.setup { render = "compact", background_colour = "#000000" }
vim.notify = notify
require("fidget").setup { text = { spinner = "dots" } }
require("trailing-whitespace").setup {}

-- Programming

require("nvim-surround").setup {}
require("Comment").setup { mappings = false }
require("nvim-autopairs").setup { map_bs = false, map_cr = false }
local lint = require "lint"
lint.linters_by_ft = { sh = { "shellcheck" }, python = { "ruff" } }
local lint_group = vim.api.nvim_create_augroup("lint_group", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = lint_group,
    callback = function() lint.try_lint() end,
})

-- stylua: ignore
require "nvim-treesitter.configs" .setup {
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
-- TODO: figure out why this takes 20ms
require("treesj").setup { use_default_keymaps = false }

-- language server configuration

require("neodev").setup {}
local coq = require "coq"
local lspconfig = require "lspconfig"
local function server(name, cfg) lspconfig[name].setup(coq.lsp_ensure_capabilities(cfg)) end

server "clangd"
server "nil_ls"
server("pyright", {
    settings = { python = { analysis = { diagnosticMode = "openFilesOnly" } } },
})
server("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })

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
