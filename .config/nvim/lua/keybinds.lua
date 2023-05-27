local modemap = vim.keymap.set
local function map(lhs, rhs, opt) modemap("", lhs, rhs, opt) end
vim.g.mapleader = " "

-- general mappings
map("<space>", "<NOP>", { noremap = true })
map("<space>qq", ":qa<CR>")
map("<space>fs", ":w<CR>")
map("<space>fS", ":wa<CR>")
map("<space>w", "<C-w>")
map("<space>d", ":bd<CR>")
map("<space><tab>", ":b#<CR>")
-- toggleterm with <A-t>
-- modemap("t", "jk", "<C-\\><C-n>", { silent = true })
modemap("t", "<A-esc>", "<C-\\><C-n>", { silent = true })

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

-- programming
map("<space>gb", ":Gitsigns toggle_current_line_blame<CR>")
modemap("n", "<space>cl", "<Plug>(comment_toggle_linewise_current)")
modemap("v", "<space>cl", "<Plug>(comment_toggle_linewise_visual)")
modemap("v", "<space>cb", "<Plug>(comment_toggle_blockwise_visual)")
map(",=", ":Neoformat<CR>") -- TODO: LspFormat once the ecosystem gets there
vim.api.nvim_create_user_command("LspFormat", function() vim.lsp.buf.format() end, {})
vim.api.nvim_create_autocmd("LspAttach", {callback = function(_args)
    map("K", ":lua vim.lsp.buf.hover()<CR>") -- TODO: defer to normal behavior
end})
map("gd", ":lua FZF.lsp_definitions({ jump_to_single_result = true })<CR>")
map("gi", ":lua FZF.lsp_implementations({ jump_to_single_result = true })<CR>")
map("gr", ":lua FZF.lsp_references({ jump_to_single_result = true })<CR>")
map("gD", ":lua FZF.lsp_declarations({ jump_to_single_result = true })<CR>")
map("gt", ":lua vim.lsp.buf.type_definition()<CR>")
map("<space>;", ":lua vim.lsp.buf.signature_help()<CR>")
map("<space>rn", ":lua vim.lsp.buf.rename()<CR>")
map("<space>ee", ":lua vim.diagnostic.open_float()<CR>")
-- TODO: next diagnostic severity awareness, toggle low severity
map("<space>en", ":lua vim.diagnostic.goto_next()<CR>")
map("<space>eN", ":lua vim.diagnostic.goto_prev()<CR>")
map("<space>gn", ":lua require'gitsigns.actions'.next_hunk()<CR>")
map("<space>gN", ":lua require'gitsigns.actions'.prev_hunk()<CR>")
map("<space>t", ":FzfLua lsp_document_symbols<CR>")
map("<space>T", ":FzfLua lsp_workspace_symbols<CR>")
map("<space>el", ":FzfLua lsp_document_diagnostics<CR>")
map("<space>eL", ":FzfLua lsp_workspace_diagnostics<CR>")
map("<space>ca", ":FzfLua lsp_code_actions<CR>")
map("<space>qf", ":FzfLua quickfix<CR>")
map("<space>i", ":RustToggleInlayHints<CR>")
-- TODO: alt+hjkl to navigate TS nodes (ctrl+alt to swap)
-- TODO: visual mode i/o to narrow/expand by TS nodes
-- try ziontee113/SelectEase or ziontee113/syntax-tree-surfer

-- fuzzy finder
map("<space>:", ":FzfLua command_history<CR>")
map("<space><space>", ":FzfLua commands<CR>")
map("<space>F", ":FzfLua files<CR>")
map("<space>ff", ":FzfLua files cwd=~<CR>")
map("<space>f/", ":FzfLua files cwd=/<CR>")
map("<space>fh", ":FzfLua oldfiles<CR>")
map("<space>fg", ":FzfLua git_files<CR>")
map("<space>G", ":FzfLua git_status<CR>")
map("<space>b", ":FzfLua buffers<CR>")
map("<space>/", ":FzfLua search_history<CR>")
map("<space>rg", ":FzfLua live_grep_native<CR>")
map("<space>l", ":FzfLua lines<CR>")
map("<space>h", ":FzfLua help_tags<CR>")
map("<space>s", ":FzfLua spell_suggest<CR>")
