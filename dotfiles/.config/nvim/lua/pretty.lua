vim.cmd [[ colorscheme custom ]]
require "statusline"

require("colorizer").setup { user_default_options = { names = false } }
require("gitsigns").setup { current_line_blame_opts = { delay = 500 } }
-- TODO: click to dismiss: https://github.com/rcarriga/nvim-notify/issues/195
local notify = require "notify"
notify.setup { render = "compact", background_colour = "#000000" }
vim.notify = notify
require("fidget").setup { text = { spinner = "dots" } }
require("dressing").setup {}

-- utils for autocommands
local pretty = vim.api.nvim_create_augroup("pretty", {})
local autocmd = function(event, f)
    vim.api.nvim_create_autocmd(event, { group = pretty, callback = f })
end
local inplace = function(f)
    local pos = vim.api.nvim_win_get_cursor(0)
    local temp = f()
    vim.api.nvim_win_set_cursor(0, pos)
    return temp
end
local makeset = function(arr)
    local temp = {}
    for _, v in ipairs(arr) do
        temp[v] = true
    end
    return temp
end

-- highlight on yank
autocmd("TextYankPost", function() vim.highlight.on_yank { timeout = 150 } end)

-- highlight lsp references
autocmd({ "CursorHold", "CursorHoldI" }, function()
    local c = vim.lsp.get_active_clients()[1]
    if c and c.supports_method "textDocument/documentHighlight" then
        vim.lsp.buf.document_highlight()
    end
end)
autocmd({ "CursorMoved", "CursorMovedI" }, vim.lsp.buf.clear_references)

-- trim whitespace when saving
autocmd("BufWritePre", function()
    inplace(function() vim.cmd [[keeppatterns %s_\s\+$__e]] end)
end)

-- highlight trailing whitespace
local ft_exclude = makeset { "lspinfo", "diff", "man", "checkhealth" }
local buftype_exclude = makeset { "terminal", "help", "nofile", "prompt", "quickfix" }
local pat = "\\s\\+$"
autocmd({ "BufEnter", "TextChanged", "BufModifiedSet" }, function()
    if
        not vim.opt.modifiable:get()
        or buftype_exclude[vim.bo.buftype]
        or ft_exclude[vim.bo.filetype]
        or vim.api.nvim_win_get_config(0).relative ~= ""
        or inplace(function() return vim.fn.search(pat) == 0 end)
    then
        return
    end
    vim.fn.matchadd("TrailingWhitespace", pat)
end)
