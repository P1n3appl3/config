vim.cmd [[highlight Blinking guifg=#cba6f8 start=<esc>[5m stop=<esc>[0m]]

require("catppuccin").setup {
    flavour = "mocha",
    -- stylua: ignore
    integrations = {
        fidget = true, hop = true, notify = true,
        treesitter = true, which_key = true, nvim_surround = true
    },
    color_overrides = {
        -- mocha = { base = "#000000", mantle = "#000000", crust = "#000000" },
    },
    custom_highlights = function(c)
        return {
            StatusLine = { fg = c.base, bg = c.blue, bold = true },
            StatusLineModified = { fg = c.base, bg = c.mauve, bold = true },

            SignColumn = { bg = c.surface0 },
            GitSignsAdd = { fg = c.green, bg = c.surface0 },
            GitSignsChange = { fg = c.yellow, bg = c.surface0 },
            GitSignsDelete = { fg = c.red, bg = c.surface0 },
            DiagnosticSignError = { fg = c.red, bg = c.surface0 },
            DiagnosticSignWarn = { fg = c.yellow, bg = c.surface0 },
            DiagnosticSignInfo = { fg = c.sky, bg = c.surface0 },
            DiagnosticSignHint = { fg = c.teal, bg = c.surface0 },
            DapBreakpoint = { fg = c.red, bg = c.surface0 },
            DapBreakpointCondition = { fg = c.yellow, bg = c.surface0 },
            DapBreakpointRejected = { fg = c.mauve, bg = c.surface0 },
            DapLogPoint = { fg = c.sky, bg = c.surface0 },
            DapStopped = { fg = c.maroon, bg = c.surface0 },

            TrailingWhitespace = { fg = c.maroon, reverse = true },
            ["@punctuation.arrow.rust"] = { fg = c.lavender, bold = true },
            ["@punctuation.fat-arrow.rust"] = { fg = c.mauve },
        }
    end,
}

vim.cmd [[colorscheme catppuccin]]

MyFoldText = function()
    -- stylua: ignore
    return vim.fn.getline(vim.v.foldstart) .. "    ("
        .. (vim.v.foldend - vim.v.foldstart) .. " lines) "
end
vim.opt.foldtext = "v:lua.MyFoldText()"

require("image").setup()
require("colorizer").setup { user_default_options = { names = false } }
require("gitsigns").setup { current_line_blame_opts = { delay = 500 } }
vim.api.nvim_create_user_command("Dismiss", require("notify").dismiss, {})
local notify = require "notify"
notify.setup { render = "compact", background_colour = "#000000" }
vim.notify = notify
require("fidget").setup { notification = { window = { winblend = 0 } } }
require("dressing").setup {}

local pretty = vim.api.nvim_create_augroup("pretty", {})
local autocmd = function(event, f)
    vim.api.nvim_create_autocmd(event, { group = pretty, callback = f })
end

-- highlight on yank
autocmd("TextYankPost", function() vim.highlight.on_yank { timeout = 150 } end)

-- highlight lsp references
autocmd({ "CursorHold", "CursorHoldI" }, function()
    for _, c in pairs(vim.lsp.get_clients()) do
        if c.supports_method "textDocument/documentHighlight" then
            vim.lsp.buf.document_highlight()
        end
    end
end)
autocmd({ "CursorMoved", "CursorMovedI" }, vim.lsp.buf.clear_references)

-- trim whitespace when saving
autocmd("BufWritePre", function()
    G.inplace(function() vim.cmd [[keeppatterns %s_\s\+$__e]] end)
end)

-- highlight trailing whitespace
local ft_exclude = G.makeset { "lspinfo", "diff", "man", "checkhealth" }
local buftype_exclude = G.makeset { "terminal", "help", "nofile", "prompt", "quickfix" }
local pat = "\\s\\+$"
autocmd({ "BufEnter", "TextChanged", "BufModifiedSet" }, function()
    if
        not vim.opt.modifiable:get()
        or buftype_exclude[vim.bo.buftype]
        or ft_exclude[vim.bo.filetype]
        or vim.api.nvim_win_get_config(0).relative ~= ""
        or G.inplace(function() return vim.fn.search(pat) == 0 end)
    then
        return
    end
    vim.fn.matchadd("TrailingWhitespace", pat)
end)
