-- TODO: trailing whitespace and mixed indent alert (obviated by formatters?)

require("colorizer").setup()

-- highlight on yank or lsp references
local general = vim.api.nvim_create_augroup("general", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = general,
    callback = function()
        vim.highlight.on_yank { timeout = 150 }
    end,
})
vim.api.nvim_create_autocmd(
    { "CursorHold", "CursorHoldI" },
    { group = general, callback = vim.lsp.buf.document_highlight }
)
vim.api.nvim_create_autocmd(
    { "CursorMoved", "CursorMovedI" },
    { group = general, callback = vim.lsp.buf.clear_references }
)

-- status line
local icons = {
    Hint = "",
    Information = "",
    Warning = "",
    Error = "",
}

local sev = {
    Hint = vim.diagnostic.severity.HINT,
    Information = vim.diagnostic.severity.INFO,
    Warning = vim.diagnostic.severity.WARN,
    Error = vim.diagnostic.severity.ERROR,
}

for l, _ in pairs(icons) do
    vim.fn.sign_define(
        "LspDiagnosticsSign" .. l,
        { text = icons[l], texthl = "LspDiagnosticsSign" .. l }
    )
end

local line_col = " %l:%-2c "
local file = " %f "
local fill = "%="

local function readonly()
    return (vim.o.readonly or not vim.o.modifiable) and "🔒" or "" -- maybe ⛔ or 🚫
end

local function lsp()
    if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return ""
    end
    local levels = {
        Hint = "%%#AquaSign#",
        Information = "%%#BlueSign#",
        Warning = "%%#OrangeSign#",
        Error = "%%#RedSign#",
    }
    -- TODO: handle progress messages manually
    local t = {}
    for l, s in pairs(levels) do
        local n = #vim.diagnostic.get(0, { severity = sev[l] })
        if n > 0 then
            t[#t + 1] = string.format(s .. " %s %s ", icons[l], n)
        end
    end
    return table.concat(t)
end

local function git()
    local status = vim.b.gitsigns_status_dict
    if not status then
        return ""
    end
    local t, add, change, del = {}, status.added, status.changed, status.removed
    if add and add > 0 then
        t[#t + 1] = "%#GitSignsAdd#+" .. add
    end
    if change and change > 0 then
        t[#t + 1] = "%#GitSignsChange#+" .. change
    end
    if del and del > 0 then
        t[#t + 1] = "%#GitSignsDelete#+" .. del
    end
    if not t then
        return ""
    end
    return "%#SignColumn# " .. table.concat(t, " ") .. " "
end

local function modcol()
    return vim.o.modified and "%#StatusLineModified#" or "%#Normal#"
end

StatusLine = {
    active = function()
        return table.concat {
            readonly(),
            file,
            git(),
            modcol(),
            fill,
            lsp(),
            "%*",
            line_col,
        }
    end,
    inactive = function()
        return table.concat { file, fill, line_col }
    end,
}

local status = vim.api.nvim_create_augroup("StatusLine", {})
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = status,
    command = "setlocal statusline=%!v:lua.StatusLine.active()",
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = status,
    command = "setlocal statusline=%!v:lua.StatusLine.inactive()",
})
