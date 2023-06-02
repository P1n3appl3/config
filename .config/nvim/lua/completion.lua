-- TODO: auto-focus first mark for snippets: https://github.com/ms-jpq/coq_nvim/issues/465
vim.g.coq_settings = {
    auto_start = "shut-up",
    xdg = true,
    keymap = { recommended = false },
    display = {
        icons = { mode = "short" },
        pum = {
            fast_close = false,
            kind_context = { "", "" },
            source_context = { "", "" },
        },
    },
}

_G.Util = {}

Util.CR = function()
    local npairs = require "nvim-autopairs"
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ "selected" }).selected ~= -1 then
            return npairs.esc "<C-y>"
        else
            return npairs.esc "<C-e>" .. npairs.autopairs_cr()
        end
    else
        return npairs.autopairs_cr()
    end
end
Util.BS = function()
    local npairs = require "nvim-autopairs"
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
        return npairs.esc "<C-e>" .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end

local function inoremap(lhs, rhs)
    vim.api.nvim_set_keymap("i", lhs, rhs, { expr = true, noremap = true })
end
inoremap("<ESC>", [[pumvisible() ? "<C-e><ESC>" : "<ESC>"]])
inoremap("<C-c>", [[pumvisible() ? "<C-e><C-c>" : "<C-c>"]])
inoremap("<tab>", [[pumvisible() ? "<C-n>" : "<tab>"]])
inoremap("<s-tab>", [[pumvisible() ? "<C-p>" : "<NOP>"]])
inoremap("<CR>", "v:lua.Util.CR()")
inoremap("<BS>", "v:lua.Util.BS()")
