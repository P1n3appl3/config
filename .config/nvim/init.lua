require "paq" {
    -- general
    "savq/paq-nvim",
    "vijaymarupudi/nvim-fzf",
    "ibhagwan/fzf-lua",
    "phaazon/hop.nvim",
    "nvim-lua/plenary.nvim",
    "rmagatti/auto-session",
    "ojroques/nvim-osc52",
    "lewis6991/impatient.nvim",
    "dstein64/vim-startuptime",
    -- TODO: toggleterm

    -- appearance
    "rktjmp/lush.nvim",
    "norcalli/nvim-colorizer.lua",
    "lewis6991/gitsigns.nvim", -- TODO: keymap or null-ls code action for hunk stage/diff
    "kyazdani42/nvim-web-devicons",
    "davidgranstrom/nvim-markdown-preview",

    -- programming
    "kylechui/nvim-surround",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "sbdchd/neoformat", -- TODO: nvim-format and use lsp when available
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    "j-hui/fidget.nvim",
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
    "kalcutter/vim-gn",
    -- "imsnif/kdl.vim", -- TODO: contribute (fix indent) and compare vs treesitter
    { "nvim-treesitter/nvim-treesitter", run = function() vim.cmd "TSUpdate" end },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    -- "mfussenegger/nvim-dap", -- TODO: configure for rust/c/python/lua
}
require "impatient" -- TODO: disable once upstreamed

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

-- vim.lsp.set_log_level "debug"
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
function _G.put(...)
    local objects = {}
    for i = 1, select("#", ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end
    print(table.concat(objects, "\n"))
    return ...
end

vim.cmd [[ function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun ]]
vim.api.nvim_create_user_command("SynGroup", "call SynGroup()", {})
vim.api.nvim_create_user_command("Reload", "so $MYVIMRC", {})
