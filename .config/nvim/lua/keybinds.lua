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

-- misc
modemap({"n", "v"}, "<C-i>", "<C-i>", { noremap = true }) -- don't group <C-i> and <tab> mappings
modemap("n", "<space>cl", "<Plug>(comment_toggle_linewise_current)")
modemap("v", "<space>cl", "<Plug>(comment_toggle_linewise_visual)")
modemap("v", "<space>cb", "<Plug>(comment_toggle_blockwise_visual)")
vim.api.nvim_create_user_command("LspFormat", function() vim.lsp.buf.format() end, {})
map("K", require("hover").hover)
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
        l = { FZF.lsp_document_diagnostics, "List" },
        L = { FZF.lsp_workspace_diagnostics, "List All" },
        -- TODO: next diagnostic severity awareness, toggle low severity
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
        u = { GITS.unstage_hunk, "Unstage Hunk" },
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
    K = { require("hover").hover_select, "Hover" },
}, { prefix = "g" })

wk.register({
    [","] = { ",", "Last match" },
    ["="] = { ":Neoformat<CR>", "Format" },
}, { prefix = "," })
