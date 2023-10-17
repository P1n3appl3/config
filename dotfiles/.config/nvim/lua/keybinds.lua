local modemap = vim.keymap.set
local function map(lhs, rhs, opt) modemap("", lhs, rhs, opt) end

-- search/replace
modemap("n", ",/", ":nohl<CR>", { silent = true })
modemap("n", "<C-/>", ":%s/")
modemap("v", "<C-/>", ":s/")

-- system clipboard
map("<C-y>", '"+y')
map("<C-p>", '"+p')

-- movement
map("j", "gj")
map("k", "gk")
map("<C-j>", "<C-e>", { noremap = true })
map("<C-k>", "<C-y>", { noremap = true })
map("s", require("hop").hint_char2)
map("S", require("hop").hint_words)
local snippy = require "snippy"
modemap({ "i", "n", "v" }, "<C-l>", function()
    if snippy.can_jump(1) then
        snippy.next()
    else
        print "No more snippets"
    end
end)
modemap({ "i", "n", "v" }, "<C-h>", function()
    if snippy.can_jump(-1) then
        snippy.previous()
    else
        print "No more snippets"
    end
end)
local alphabet = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #alphabet do -- select mode: unmap all letters
    local c = alphabet:sub(i, i)
    modemap("s", c, c)
end

-- misc
modemap({ "n", "v" }, "<C-i>", "<C-i>", { noremap = true }) -- don't group <C-i> and <tab> mappings
modemap("n", "<space>cl", "<Plug>(comment_toggle_linewise_current)")
modemap("v", "<space>cl", "<Plug>(comment_toggle_linewise_visual)")
modemap("v", "<space>cb", "<Plug>(comment_toggle_blockwise_visual)")
local format = function()
    local c = vim.lsp.get_active_clients()[1]
    if c and c.supports_method "textDocument/formatting" then
        local t = vim.api.nvim_buf_get_changedtick(0)
        local name = "Language Server"
        if c.name ~= "" then name = c.name end
        vim.lsp.buf.format()
        if t ~= vim.api.nvim_buf_get_changedtick(0) then
            print(name .. ": formatted buffer")
        else -- TODO: file upstream bug to tell if lsp formatter failed vs noop'd
            print(name .. ": no changes made")
        end
    else
        vim.cmd [[ Neoformat ]]
    end
end

local sev = vim.diagnostic.severity
local sev_names = { "ERROR", "WARN", "INFO", "HINT" }
local current_severity = sev.HINT
local change_min_severity = function(new_min)
    local s = (new_min + 3) % 4 + 1 -- wrap around
    current_severity = s
    print("Minimum severity: " .. sev_names[s])
    local temp = { severity = { min = s } }
    vim.diagnostic.config { signs = temp, underline = temp }
end
local increase_min_severity = function() change_min_severity(current_severity - 1) end
local decrease_min_severity = function() change_min_severity(current_severity + 1) end

local diagnostics_active = true
local toggle_diagnostics = function()
    diagnostics_active = not diagnostics_active
    local d = vim.diagnostic
    -- stylua: ignore
    if diagnostics_active then d.show() else d.hide() end
end

-- TODO: remove once https://github.com/neovim/neovim/pull/24331 works
map("K", vim.lsp.buf.hover)

-- TODO: alt+hjkl to navigate TS nodes (ctrl+alt to swap)
-- try ziontee113/SelectEase or ziontee113/syntax-tree-surfer

local wk = require "which-key"
FZF = require "fzf-lua"
GITS = require "gitsigns"

wk.register({
    q = {
        name = "Quit/Quickfix",
        q = { ":qa<CR>", "Quit" },
        f = { FZF.quickfix, "Quickfix" },
    },
    r = {
        name = "Rename/Ripgrep",
        n = { vim.lsp.buf.rename, "Rename" },
        g = { FZF.live_grep_native, "Ripgrep" },
    },
    F = { FZF.files, "Files" },
    f = {
        name = "Files",
        s = { ":w<CR>", "Save" },
        S = { ":wa<CR>", "Save All" },
        f = { ":FzfLua files cwd=~<CR>", "from $HOME" },
        ["/"] = { ":FzfLua files cwd=/<CR>", "from root" },
        h = { FZF.oldfiles, "from history" },
        g = { FZF.git_files, "from git" },
    },
    e = {
        name = "Errors",
        e = { vim.diagnostic.open_float, "Details" },
        n = { vim.diagnostic.goto_next, "Next" },
        N = { vim.diagnostic.goto_prev, "Prev" },
        l = { FZF.diagnostics_document, "List" },
        L = { FZF.diagnostics_workspace, "List All" },
        t = { toggle_diagnostics, "Toggle" },
        s = { increase_min_severity, "Less Noise" },
        S = { decrease_min_severity, "More Noise" },
    },
    d = { ":bd<CR>", "Close Buffer" },
    ["<tab>"] = { ":b#<CR>", "Last Buffer" },
    b = { FZF.buffers, "Buffers" },
    -- TODO: alias https://github.com/folke/which-key.nvim/issues/160
    w = { "<C-W>", "+Window" },
    g = {
        name = "Git",
        b = { GITS.toggle_current_line_blame, "Blame" },
        n = { GITS.next_hunk, "Next Hunk" },
        N = { GITS.prev_hunk, "Prev Hunk" },
        h = { GITS.preview_hunk_inline, "Show Hunk" },
        s = { GITS.stage_hunk, "Stage Hunk" },
        u = { GITS.undo_stage_hunk, "Undo Stage Hunk" },
    },
    G = { FZF.git_status, "Git Status" },
    t = { FZF.lsp_document_symbols, "Symbols" },
    T = { FZF.lsp_workspace_symbols, "Workspace Symbols" },
    [";"] = { vim.lsp.buf.signature_help, "Signature Help" },
    [":"] = { FZF.command_history, "Command History" },
    -- TODO: maybe use wilder.nvim palette
    ["<space>"] = { FZF.commands, "Commands" },
    ["/"] = { FZF.search_history, "Search History" },
    ca = { FZF.lsp_code_actions, "Code Actions" },
    s = { FZF.spell_suggest, "Spelling" },
    h = { FZF.help_tags, "Help" },
    l = { FZF.lines, "Search Lines" },
    i = { ":RustToggleInlayHints<CR>", "Inlay Hints" },
    j = { require("treesj").toggle, "Toggle Join" },
}, { prefix = "<space>" })

local function fzf_g(command)
    return function() FZF["lsp_" .. command] { jump_to_single_result = true } end
end
wk.register({
    d = { fzf_g "definitions", "Definition" },
    i = { fzf_g "implementations", "Implementation" },
    r = { fzf_g "references", "References" },
    D = { fzf_g "declarations", "Declaration" },
    t = { fzf_g "typedefs", "Typedef" },
}, { prefix = "g" })

wk.register({
    [","] = { ",", "Last match" },
    ["="] = { format, "Format" },
}, { prefix = "," })
