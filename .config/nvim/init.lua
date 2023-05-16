-- NOTE: plugin fetching is handled by nix, see ~/.config/nixpkgs/vim.nix
vim.loader.enable()

-- general options
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
-- TODO: searching for string that's not present requires prompt with this?
-- o.cmdheight = 0

-- vim.lsp.set_log_level "debug" -- TODO: prettier lsp log viewer
vim.diagnostic.config { virtual_text = false, severity_sort = true }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { signs = true, underline = true, update_in_insert = false }
)

-- my other configs
vim.cmd [[colorscheme custom]]
require "pretty"
require "completion"
require "plugins"
require "keybinds"

-- debug
vim.cmd [[ function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun ]] -- TODO: if synID returns 0 call TSCaptureUnderCursor
vim.api.nvim_create_user_command("SynGroup", "call SynGroup()", {})
vim.api.nvim_create_user_command("Reload", "so $MYVIMRC", {})

