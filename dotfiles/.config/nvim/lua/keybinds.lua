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
G.lazy_load("hop", {}, "hop.nvim")
map("s", G.lazy("hop", "hint_char2"))
map("S", G.lazy("hop", "hint_words"))
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    pattern = "*:s", -- select mode: unmap all letters
    once = true,
    callback = function()
        local alphabet = "abcdefghijklmnopqrstuvwxyz"
        for i = 1, #alphabet do
            local c = alphabet:sub(i, i)
            modemap("s", c, c)
        end
    end,
})

-- comment toggling
local com = require "Comment.api"
modemap("n", "<space>cl", com.toggle.linewise.current)
local visual_com = function(method)
    return function()
        vim.fn.feedkeys(":", "nx")
        com.toggle[method](vim.fn.visualmode())
    end
end
modemap("x", "<space>cl", visual_com "linewise")
modemap("x", "<space>cb", visual_com "blockwise")

-- prevent aliasing of <C-i> and <tab> mappings
modemap({ "n", "v" }, "<C-i>", "<C-i>", { noremap = true })
local format = function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, c in pairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
        if c.supports_method "textDocument/formatting" then
            local t = vim.api.nvim_buf_get_changedtick(0)
            local name = "Language Server"
            if c.name ~= "" then name = c.name end
            vim.lsp.buf.format()
            if t ~= vim.api.nvim_buf_get_changedtick(0) then
                vim.cmd.write()
                print(name .. ": formatted buffer")
            else
                print(name .. ": no changes made")
            end
            return
        end
    end
    vim.cmd [[ Neoformat ]]
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

map("K", vim.lsp.buf.hover)

G.lazy_load("fzf-lua", {
    preview_layout = "vertical",
    preview_vertical = "up",
    keymap = { fzf = { ["ctrl-u"] = "half-page-up", ["ctrl-d"] = "half-page-down" } },
    files = { fd_opts = "-Htf --mount --color always" },
    grep = { rg_opts = "-S. --no-heading --color always" },
})
RUNFZF = function(command, args) return G.lazy("fzf-lua", command, args) end

G.lazy_load("treesj", { use_default_keymaps = false })
GITS = require "gitsigns"

local wk = require "which-key"
wk.setup {
    plugins = {
        presets = { operators = false, motions = false, text_objects = false },
    },
    layout = { width = { max = 40 } },
    triggers = { "g", "z", "<leader>", ",", "<c-w>", "<c-r>", '"', "'", "`" },
}
wk.register({
    q = {
        name = "Quit/Quickfix",
        q = { ":qa<CR>", "Quit" },
        f = { RUNFZF "quickfix", "Quickfix" },
    },
    r = {
        name = "Rename/Ripgrep",
        n = { vim.lsp.buf.rename, "Rename" },
        g = { RUNFZF "live_grep_native", "Ripgrep" },
    },
    F = { RUNFZF "files", "Files" },
    f = {
        name = "Files",
        s = { ":w<CR>", "Save" },
        S = { ":wa<CR>", "Save All" },
        f = { RUNFZF("files", { cwd = "~" }), "from $HOME" },
        ["/"] = { RUNFZF("files", { cwd = "/" }), "from root" },
        h = { RUNFZF "oldfiles", "from history" },
        g = { RUNFZF "git_files", "from git" },
    },
    e = {
        name = "Errors",
        e = { vim.diagnostic.open_float, "Details" },
        n = { vim.diagnostic.goto_next, "Next" },
        N = { vim.diagnostic.goto_prev, "Prev" },
        l = { RUNFZF "diagnostics_document", "List" },
        L = { RUNFZF "diagnostics_workspace", "List All" },
        t = { toggle_diagnostics, "Toggle" },
        s = { increase_min_severity, "Less Noise" },
        S = { decrease_min_severity, "More Noise" },
    },
    d = { ":bd<CR>", "Close Buffer" },
    ["<tab>"] = { ":b#<CR>", "Last Buffer" },
    b = { RUNFZF "buffers", "Buffers" },
    w = { "<C-W>", "+Window" },
    g = {
        name = "Git",
        b = { GITS.toggle_current_line_blame, "Blame" },
        n = { GITS.next_hunk, "Next Hunk" },
        N = { GITS.prev_hunk, "Prev Hunk" },
        h = { GITS.preview_hunk_inline, "Show Hunk" },
        s = { GITS.stage_hunk, "Stage Hunk" },
        u = { GITS.undo_stage_hunk, "Undo Stage Hunk" },
        r = { GITS.reset_hunk, "Reset Hunk" },
    },
    G = { RUNFZF "git_status", "Git Status" },
    t = { RUNFZF "lsp_document_symbols", "Symbols" },
    T = { RUNFZF "lsp_workspace_symbols", "Workspace Symbols" },
    [";"] = { vim.lsp.buf.signature_help, "Signature Help" },
    [":"] = { RUNFZF "command_history", "Command History" },
    ["<space>"] = { RUNFZF "commands", "Commands" },
    ["/"] = { RUNFZF "search_history", "Search History" },
    ca = { RUNFZF "lsp_code_actions", "Code Actions" },
    s = { RUNFZF "spell_suggest", "Spelling" },
    h = { RUNFZF "help_tags", "Help" },
    l = { RUNFZF "lines", "Search Lines" },
    i = { ":RustToggleInlayHints<CR>", "Inlay Hints" },
    j = { G.lazy("treesj", "toggle"), "Split / Join" },
}, { prefix = "<space>" })

local function fzf_g(command)
    return G.lazy("fzf-lua", "lsp_" .. command, { jump_to_single_result = true })
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
