require("Comment").setup { mappings = false }
local comment = require "Comment.ft"
comment.beancount = ";%s"
comment.gn = "#%s"

require("nvim-surround").setup {}

vim.g.startuptime_exe_path = "nvim"
require("bigfile").setup {}

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
