local modemap = vim.keymap.set
local prompt = vim.fn.input
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
    for _, c in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
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
    vim.cmd [[Neoformat]]
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

local toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

G.lazy_load("fzf-lua", {
    winopts = { preview = { layout = "vertical", vertical = "up" } },
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
    icons = { rules = false },
}

local dap = require "dap"
wk.add {
    { "<space>q", group = "Quit/Quickfix" },
    { "<space>qq", ":qa<CR>", desc = "Quit" },
    { "<space>qf", RUNFZF "quickfix", desc = "Quickfix" },

    { "<space>r", group = "Rename/Ripgrep" },
    { "<space>rn", vim.lsp.buf.rename, desc = "Rename" },
    { "<space>rg", RUNFZF "live_grep_native", desc = "Ripgrep" },

    { "<space>f", group = "Files" },
    { "<space>fs", ":w<CR>", desc = "Save" },
    { "<space>fS", ":wa<CR>", desc = "Save All" },
    { "<space>ff", RUNFZF("files", { cwd = "~" }), desc = "from $HOME" },
    { "<space>f/", RUNFZF("files", { cwd = "/" }), desc = "from root" },
    { "<space>fh", RUNFZF "oldfiles", desc = "from history" },
    { "<space>fg", RUNFZF "git_files", desc = "from git" },
    { "<space>F", RUNFZF "files", desc = "Files" },

    { "<space>e", group = "Errors" },
    { "<space>ee", vim.diagnostic.open_float, desc = "Details" },
    { "<space>en", vim.diagnostic.goto_next, desc = "Next" },
    { "<space>eN", vim.diagnostic.goto_prev, desc = "Prev" },
    { "<space>el", RUNFZF "diagnostics_document", desc = "List" },
    { "<space>eL", RUNFZF "diagnostics_workspace", desc = "List All" },
    { "<space>et", toggle_diagnostics, desc = "Toggle" },
    { "<space>es", increase_min_severity, desc = "Less Noise" },
    { "<space>eS", decrease_min_severity, desc = "More Noise" },

    { "<space>g", group = "Git" },
    { "<space>gb", GITS.toggle_current_line_blame, desc = "Blame" },
    { "<space>gn", GITS.next_hunk, desc = "Next Hunk" },
    { "<space>gN", GITS.prev_hunk, desc = "Prev Hunk" },
    { "<space>gh", GITS.preview_hunk_inline, desc = "Show Hunk" },
    { "<space>gs", GITS.stage_hunk, desc = "Stage Hunk" },
    { "<space>gu", GITS.undo_stage_hunk, desc = "Undo Stage Hunk" },
    { "<space>gr", GITS.reset_hunk, desc = "Reset Hunk" },
    { "<space>G", RUNFZF "git_status", desc = "Git Status" },

    { "<space>a", group = "Debug" },
    { "<space>ad", dap.run_last, desc = "Run Last" },
    { "<space>ab", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
    -- stylua: ignore
    { "<space>aB", desc = "Set conditional breakpoint",
        function() dap.set_breakpoint(prompt "Breakpoint condition: ") end },
    -- stylua: ignore
    { "<space>al", desc = "Set logpoint",
        function() dap.set_breakpoint(nil, nil, prompt "Log point message: ") end },
    { "<space>a<space>", RUNFZF "dap_commands", desc = "Commands" },
    { "<space>ac", dap.continue, desc = "Continue" },
    { "<space>an", dap.step_over, desc = "Step Over" },
    { "<space>as", dap.step_over, desc = "Step In" },
    { "<space>af", dap.step_over, desc = "Step Out" },
    { "<space>ar", dap.repl.toggle, desc = "Toggle Repl" },
    { "<space>aS", require("dap-python").debug_selection, desc = "Debug Selection" },
    { "<space>a<return>", dap.terminate, desc = "Choose Config" },
    { "<space>ai", ":DapVirtualTextToggle<CR>", desc = "Toggle Virtual Text" },
    { "<space>aq", dap.terminate, desc = "Close Session" },

    { "<space>t", RUNFZF "lsp_document_symbols", desc = "Symbols" },
    { "<space>T", RUNFZF "lsp_workspace_symbols", desc = "Workspace Symbols" },
    { "<space>;", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "<space>:", RUNFZF "command_history", desc = "Command History" },
    { "<space><space>", RUNFZF "commands", desc = "Commands" },
    { "<space>/", RUNFZF "search_history", desc = "Search History" },
    { "<space>ca", RUNFZF "lsp_code_actions", desc = "Code Actions" },
    { "<space>s", RUNFZF "spell_suggest", desc = "Spelling" },
    { "<space>h", RUNFZF "help_tags", desc = "Help" },
    { "<space>H", RUNFZF "highlights", desc = "Highlight" },
    { "<space>l", RUNFZF "lines", desc = "Search Lines" },
    { "<space>i", toggle_inlay_hints, desc = "Inlay Hints" },
    { "<space>j", G.lazy("treesj", "toggle"), desc = "Split / Join" },

    { "<space>d", ":bd<CR>", desc = "Close Buffer" },
    { "<space><tab>", ":b#<CR>", desc = "Last Buffer" },
    { "<space>b", RUNFZF "buffers", desc = "Buffers" },
    { "<space>w", proxy = "<C-W>", desc = "+Window" },

    { ",,", ",", desc = "Last match" },
    { ",=", format, desc = "Format" },
}

local function fzf_g(command)
    return G.lazy("fzf-lua", "lsp_" .. command, { jump_to_single_result = true })
end

wk.add {
    { "gd", fzf_g "definitions", desc = "Definition" },
    { "gi", fzf_g "implementations", desc = "Implementation" },
    { "gr", fzf_g "references", desc = "References" },
    { "gD", fzf_g "declarations", desc = "Declaration" },
    { "gt", fzf_g "typedefs", desc = "Typedef" },
}
