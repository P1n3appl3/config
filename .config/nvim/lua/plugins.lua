local nix_rtp = vim.api.nvim_list_runtime_paths()[1] .. "/pack/myNeovimPackages/start/"
local function nix_plugin(name, extra)
    local t = extra or {}
    t.dir = nix_rtp .. name
    return t
end

local plugin_map = {
    -- General

    ["ibhagwan/fzf-lua"] = {
        opts = {
            preview_layout = "vertical",
            preview_vertical = "up",
            keymap = {
                fzf = { ["ctrl-u"] = "half-page-up", ["ctrl-d"] = "half-page-down" },
            },
            files = { fd_opts = "-Htf --mount --color always" },
            grep = { rg_opts = "-S. --no-heading --color always" },
        },
    },
    ["phaazon/hop.nvim"] = { opts = {}, keys = { "s", "S" } },
    ["rmagatti/auto-session"] = {
        opts = { auto_save_enabled = true, auto_restore_enabled = false },
    },
    ["dstein64/vim-startuptime"] = {
        cmd = "StartupTime",
        init = function() vim.g.startuptime_exe_path = "nvim" end,
    },
    ["folke/which-key.nvim"] = {
        event = "VeryLazy",
        init = function() vim.o.timeoutlen = 300 end,
        opts = {
            plugins = {
                presets = { operators = false, motions = false, text_objects = false },
            },
            layout = { width = { max = 40 } },
            triggers = { "g", "z", "<leader>", ",", "<c-w>", "<c-r>", '"', "'", "`" },
        },
    },
    ["ojroques/nvim-osc52"] = {
        init = function()
            local function copy(lines, _) require("osc52").copy(table.concat(lines, "\n")) end
            local function paste()
                return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" }
            end
            if vim.env.SSH_TTY then
                vim.g.clipboard = {
                    name = "osc52",
                    copy = { ["+"] = copy, ["*"] = copy },
                    paste = { ["+"] = paste, ["*"] = paste },
                }
            end
        end,
    },
    "wsdjeg/vim-fetch",
    "nvim-lua/plenary.nvim",

    -- Appearance

    "rktjmp/lush.nvim",
    ["NvChad/nvim-colorizer.lua"] = { opts = { user_default_options = { names = false } } },
    "nvim-tree/nvim-web-devicons",
    ["lewis6991/gitsigns.nvim"] = {
        opts = { keymaps = {}, current_line_blame_opts = { delay = 500 } },
    },
    ["stevearc/dressing.nvim"] = { event = "VeryLazy", opts = {} },
    ["rcarriga/nvim-notify"] = {
        -- TODO: click to dismiss
        opts = { render = "compact", background_colour = "#000000" },
        init = function() vim.notify = require "notify" end,
    },
    ["j-hui/fidget.nvim"] = { opts = { text = { spinner = "dots" } } },

    -- Programming

    ["kylechui/nvim-surround"] = { opts = {} },
    ["numToStr/Comment.nvim"] = { opts = { mappings = false } },
    ["windwp/nvim-autopairs"] = { opts = { map_bs = false, map_cr = false } },
    -- TODO: nvim-format + use lsp when possible
    ["sbdchd/neoformat"] = { keys = { { ",=", ":Neoformat<CR>", desc = "Format" } } },
    -- TODO: mfussenger/nvim-dap with lldb for rust
    "neovim/nvim-lspconfig",
    ["mfussenegger/nvim-lint"] = {
        ft = { "sh", "python" },
        config = function()
            local lint = require "lint"
            lint.linters_by_ft = { sh = { "shellcheck" }, python = { "ruff" } }
            local lint_group = vim.api.nvim_create_augroup("lint_group", {})
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
                group = lint_group,
                callback = function() lint.try_lint() end,
            })
        end,
    },
    ["LnL7/vim-nix"] = { ft = "nix" },
    ["kalcutter/vim-gn"] = { ft = "gn" },
    ["folke/neodev.nvim"] = { opts = {} },
    ["simrat39/rust-tools.nvim"] = {
        keys = { { "<space>i", ":RustToggleInlayHints<CR>", desc = "Inlay Hints" } },
    },
    -- stylua: ignore
    nix_plugin("nvim-treesitter", { main = "nvim-treesitter.configs", opts = {
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
    }}),
    nix_plugin "nvim-treesitter-textobjects",
    nix_plugin(
        "nvim-treesitter-context",
        { opts = { patterns = { python = { "if", "elif" } } } }
    ),
    ["Wansmer/treesj"] = {
        opts = { use_default_keymaps = false },
        keys = { { "<space>j", ":TSJToggle<CR>", desc = "Toggle Join" } },
    },
    nix_plugin "coq_nvim",
    nix_plugin "coq.artifacts",
}

local plugins = {}
for k, v in pairs(plugin_map) do
    if type(k) ~= "number" then v[1] = k end
    table.insert(plugins, v)
end
require("lazy").setup(plugins, { performance = { reset_packpath = false } })

-- language server configuration

local lspconfig = require "lspconfig"
local coq = require "coq"
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
