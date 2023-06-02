-- general options
vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
local o = vim.opt
o.gdefault = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
-- TODO: find an equivalent to vim's :set wrap smoothscroll
o.foldenable = false
o.updatetime = 500
o.mouse = "a"
o.mousemodel = "extend"
o.scrolloff = 7
o.wildignore = { "*.o", "*.obj", "*.pyc" }
o.shortmess:append "cI"
-- https://github.com/neovim/neovim/issues/20380
-- o.cmdheight = 0

-- vim.lsp.set_log_level "debug" -- TODO: prettier lsp log viewer
vim.diagnostic.config { virtual_text = false, severity_sort = true }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { signs = true, underline = true, update_in_insert = false }
)

-- my config
require "completion"
require "plugins"
require "pretty"
require "keybinds"

-- debug
vim.api.nvim_create_user_command("SynGroup", function()
    local function findRoot(id, tree)
        local transId = vim.fn.synIDtrans(id)
        local name = vim.fn.synIDattr(id, "name")
        table.insert(tree, name)
        if id == transId then
            if #tree > 0 then
                print(table.concat(tree, " -> "))
            else
                vim.cmd "TSCaptureUnderCursor"
            end
        else
            findRoot(transId, tree)
        end
    end

    local id = vim.fn.synID(vim.fn.line ".", vim.fn.col ".", 0)
    findRoot(id, {})
end, {})
vim.api.nvim_create_user_command("Reload", "so $MYVIMRC", {})
