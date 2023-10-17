local icons = { Hint = "", Info = "", Warn = "", Error = "" }
local ls = vim.diagnostic.severity
local sev = { Hint = ls.ERROR, Info = ls.WARN, Warn = ls.INFO, Error = ls.HINT }

for k, v in pairs(icons) do
    vim.fn.sign_define("DiagnosticSign" .. k, { text = v, texthl = "DiagnosticSign" .. k })
end

local function readonly() return (vim.o.readonly or not vim.o.modifiable) and "🔒" or "" end

local function lsp()
    if vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then return "" end
    local levels = {
        Hint = "%%#AquaSign#",
        Info = "%%#BlueSign#",
        Warn = "%%#OrangeSign#",
        Error = "%%#RedSign#",
    }
    local t = {}
    for l, s in pairs(levels) do
        local n = #vim.diagnostic.get(0, { severity = sev[l] })
        if n > 0 then t[#t + 1] = string.format(s .. " %s %s ", icons[l], n) end
    end
    return table.concat(t)
end

local function git()
    local status = vim.b.gitsigns_status_dict ---@diagnostic disable-line: undefined-field
    if not status then return "" end
    local t, add, change, del = {}, status.added, status.changed, status.removed
    if add and add > 0 then t[#t + 1] = "%#GitSignsAdd#+" .. add end
    if change and change > 0 then t[#t + 1] = "%#GitSignsChange#+" .. change end
    if del and del > 0 then t[#t + 1] = "%#GitSignsDelete#+" .. del end
    if not t then return "" end
    return "%#SignColumn# " .. table.concat(t, " ") .. " "
end

local function modified() return vim.o.modified and "%#StatusLineModified#" or "%#Normal#" end

local line_col = " %l:%-2c "
local file = " %f "
local fill = "%="
local reset = "%*"

StatusLine = {
    active = function()
        -- stylua: ignore
        return table.concat {
            readonly(), file, git(), modified(),
            fill, lsp(), reset, line_col,
        }
    end,
    inactive = function() return table.concat { file, fill, line_col } end,
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
