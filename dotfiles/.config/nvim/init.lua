vim.loader.enable()
vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
vim.diagnostic.config { virtual_text = false, severity_sort = true }
local o = vim.opt
o.gdefault = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.updatetime = 500
o.timeoutlen = 300
o.mouse = "a"
o.mousemodel = "extend"
o.scrolloff = 7
o.wildignore = { "*.o", "*.obj", "*.pyc" }
o.shortmess:append "cI"

require "util"
require "pretty"
require "statusline"

require "plugins"
require "completion"
require "lsp"
require "debugger"

require "keybinds"

vim.filetype.add {
    extension = { nasm = "nasm", nbt = "numbat", vasm = "vasm" },
}

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "markdown", "gitcommit" },
    callback = function()
        o.spell = true
        o.shiftwidth = 2
        o.conceallevel = 2
    end,
})

require("osc52").setup { silent = true, trim = true, max_length = 2 ^ 16 }
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
