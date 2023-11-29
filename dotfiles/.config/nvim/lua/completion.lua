local cmp = require "cmp"
local snippy = require "snippy"
snippy.setup { hl_group = "SnippetPlaceholder" }
-- stylua: ignore start
vim.keymap.set({ "i", "n", "v" }, "<C-l>", function()
    if snippy.can_jump(1) then snippy.next() else print "No more snippets" end
end)
vim.keymap.set({ "i", "n", "v" }, "<C-h>", function()
    if snippy.can_jump(-1) then snippy.previous() else print "No more snippets" end
end)
-- stylua: ignore end

require("nvim-autopairs").setup {}
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup {
    snippet = { expand = function(args) snippy.expand_snippet(args.body) end },
    performance = { max_view_entries = 20 },
    sources = cmp.config.sources {
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "snippy" },
        { name = "buffer" },
        { name = "path" },
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
                local icon, hl_group =
                    require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                if icon then
                    item.kind = icon
                    item.kind_hl_group = hl_group
                    return item
                end
            end
            item = require("lspkind").cmp_format {
                mode = "symbol_text",
                maxwidth = 30,
                ellipsis_char = "…",
            }(entry, item)
            local strings = vim.split(item.kind, "%s", { trimempty = true })
            item.kind = " " .. (strings[1] or "") .. " "
            item.menu = "   (" .. (strings[2] or "") .. ")"
            return item
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-u>"] = cmp.mapping.scroll_docs(-8),
        ["<C-d>"] = cmp.mapping.scroll_docs(8),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Esc>"] = cmp.mapping(function(fallback)
            cmp.mapping.abort()
            fallback()
        end),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm { select = false }
            else
                fallback()
            end
        end, { "i" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
            if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            elseif
                col ~= 0
                and vim.api
                        .nvim_buf_get_lines(0, line - 1, line, true)[1]
                        :sub(col, col)
                        :match "%s"
                    == nil
            then
                cmp.complete()
            else
                fallback()
            end
        end, { "i" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
            else
                fallback()
            end
        end, { "i" }),
    },
}
