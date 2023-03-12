vim.g.coq_settings = {
    auto_start = "shut-up",
    xdg = true,
    keymap = { recommended = false },
    display = {
        icons = { mode = "short" }, -- TODO: pick better icons
        pum = {
            fast_close = false,
            kind_context = { "", "" },
            source_context = { "", "" },
        },
    },
}

local npairs = require "nvim-autopairs"
npairs.setup()
_G.Util = {}

Util.CR = function()
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
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
        return npairs.esc "<C-e>" .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end

vim.api.nvim_set_keymap(
    "i",
    "<esc>",
    [[pumvisible() ? "<C-e><esc>" : "<esc>"]],
    { expr = true, noremap = true }
)
vim.api.nvim_set_keymap(
    "i",
    "<tab>",
    [[pumvisible() ? "<C-n>" : "<tab>"]],
    { expr = true, noremap = true }
)
vim.api.nvim_set_keymap("i", "<s-tab>", "<C-p>", { noremap = true })
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.Util.CR()", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<BS>", "v:lua.Util.BS()", { expr = true, noremap = true })

require "coq_3p" {
    { src = "nvimlua", short_name = "nLUA" },
}
