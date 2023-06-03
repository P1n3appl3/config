vim.loader.enable()
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
    -- TODO: control min diagnostic level
    vim.lsp.diagnostic.on_publish_diagnostics,
    { signs = true, underline = true, update_in_insert = false }
)

require "completion"
require "plugins"
require "pretty"
require "keybinds"

vim.api.nvim_create_user_command("Reload", "so $MYVIMRC", {})
