local lush = require "lush"
local c = lush.hsl
-- use :Lushify and :Inspect for debugging
-- stylua: ignore start
local light0 = c "#fbf1c7"
local light1 = c "#ebdbb2"
local light2 = c "#d5c4a1"
local light3 = c "#bdae93"
local light4 = c "#a89984"
local gray   = c "#928374"
local dark4  = c "#7c6f64"
local dark3  = c "#665c54"
local dark2  = c "#504945"
local dark1  = c "#3c3836"
local dark0  = c "#161616"
local red         = c "#fb4934"
local dark_red    = c "#cc241d"
local green       = c "#b8bb26"
local dark_green  = c "#98971a"
local yellow      = c "#fabd2f"
local dark_yellow = c "#d79921"
local blue        = c "#83a598"
local dark_blue   = c "#458588"
local purple      = c "#d3869b"
local dark_purple = c "#b16286"
local aqua        = c "#8ec07c"
local dark_aqua   = c "#689d6a"
local orange      = c "#fe8019"
local dark_orange = c "#d65d0e"
-- stylua: ignore end
local light_red = red.lighten(30).de(30)

vim.g.terminal_color_0 = dark0.hex
vim.g.terminal_color_8 = gray.hex
vim.g.terminal_color_1 = dark_red.hex
vim.g.terminal_color_9 = red.hex
vim.g.terminal_color_2 = dark_green.hex
vim.g.terminal_color_10 = green.hex
vim.g.terminal_color_3 = dark_yellow.hex
vim.g.terminal_color_11 = yellow.hex
vim.g.terminal_color_4 = dark_blue.hex
vim.g.terminal_color_12 = blue.hex
vim.g.terminal_color_5 = dark_purple.hex
vim.g.terminal_color_13 = purple.hex
vim.g.terminal_color_6 = dark_aqua.hex
vim.g.terminal_color_14 = aqua.hex
vim.g.terminal_color_7 = light4.hex
vim.g.terminal_color_15 = light1.hex

---@diagnostic disable: undefined-global
return lush(function(functions)
    local sym = functions.sym
    return {
        Normal { fg = light1, bg = dark0 },
        Comment { fg = gray, gui = "italic" },
        SignColumn { bg = dark1 },
        NonText { fg = dark2 },
        Search { fg = yellow, gui = "reverse" },
        IncSearch { fg = orange, gui = "reverse" },
        LineNr { fg = gray },
        CursorLineNr { fg = yellow },
        MatchParen { bg = dark3, gui = "bold" },
        Visual { bg = dark3, gui = "reverse" },
        VisualNOS { Visual },
        TermCursorNC { fg = light3, gui = "reverse" },
        WarningMsg { fg = red, gui = "bold" },
        ErrorMsg { WarningMsg, gui = "bold,reverse" },
        VertSplit { fg = dark3 },
        MsgArea { Normal },
        ModeMsg { fg = yellow, gui = "bold" },
        MoreMsg { ModeMsg },
        Pmenu { bg = dark1 },
        PmenuSel { fg = dark1, bg = blue, gui = "bold" },
        WildMenu { PmenuSel, gui = "bold,reverse" },
        PmenuSbar { bg = dark1 },
        PmenuThumb { bg = dark4 },
        Question { fg = orange, gui = "bold" },
        SpecialKey { fg = light4 },
        StatusLine { fg = light4, gui = "bold,reverse" },
        StatusLineNC { bg = dark2 },
        StatusLineModified { fg = yellow, bg = dark_purple.darken(50), gui = "bold" },
        TabLineSel { bg = dark2 },
        TabLine {},
        TabLineFill {},
        Title { fg = green, gui = "bold" },
        Directory { Title },
        Underlined { gui = "underline" },
        Bold { gui = "bold" },
        Italic { gui = "italic" },
        Error { fg = red, gui = "bold,underline" },
        Todo { fg = light0, gui = "bold,italic" },
        Folded { bg = dark2, fg = orange },
        FoldColumn { Folded },

        String { fg = green },
        Constant { fg = purple }, -- Character Number Boolean Float
        Identifier { fg = blue },
        Function { fg = green, gui = "bold" },
        Statement { fg = red }, -- Conditional Repeat Label Keyword Exception
        Operator { Normal },
        PreProc { fg = aqua }, -- Include Define Macro Precondit
        Type { fg = yellow }, -- Typedef
        StorageClass { fg = orange },
        Structure { fg = aqua },
        Special { fg = orange }, -- Delimiter SpecialComment
        SpecialChar { fg = red },
        Tag { fg = aqua, gui = "bold" },
        Debug { fg = red },

        DiagnosticError { fg = red },
        DiagnosticWarn { fg = yellow },
        DiagnosticInfo { fg = blue },
        DiagnosticHint { fg = aqua },
        DiagnosticUnderlineError { sp = red, gui = "undercurl" },
        DiagnosticUnderlineWarn { sp = yellow, gui = "underdashed" },
        DiagnosticUnderlineInfo { sp = blue, gui = "underdotted" },
        DiagnosticUnderlineHint { sp = aqua, gui = "underdotted" },
        DiagnosticSignError { SignColumn, fg = red },
        DiagnosticSignWarn { SignColumn, fg = yellow },
        DiagnosticSignInfo { SignColumn, fg = blue },
        DiagnosticSignHint { SignColumn, fg = aqua },
        -- VirtualText Floating (with the 4 level variants)
        LspCodeLens { fg = gray },
        LspReferenceText { bg = dark1 },
        LspReferenceRead { LspReferenceText },
        LspReferenceWrite { bg = dark1.rotate(-10).saturate(10) },
        LspSignatureActiveParameter { gui = "bold" },

        sym "@lsp.type.text" { Normal },
        sym "@lsp.type.string" { String },
        sym "@lsp.type.pol" { Identifier },
        sym "@lsp.type.number" { Constant },
        sym "@lsp.type.bool" { Constant },
        sym "@lsp.type.keyword" { Statement },
        sym "@lsp.type.delim" { Special },
        sym "@lsp.type.punct" { Special },
        sym "@lsp.type.operator" { Special },
        sym "@lsp.type.heading" { Special },
        sym "@lsp.type.escape" { Special },
        sym "@lsp.type.raw" { Comment },
        sym "@lsp.type.event" { gui = "bold" },

        sym "@lsp.type.selfKeyword" { Statement },
        sym "@lsp.type.formatSpecifier" { Special },
        sym "@lsp.type.unresolvedReference" { LspReferenceWrite },
        sym "@lsp.type.builtinType" { Type },
        sym "@lsp.type.attributeBracket" { Special },
        sym "@lsp.type.derive" { Type },
        sym "@lsp.type.generic" { Identifier },
        sym "@lsp.type.interface" { fg = purple },
        -- sym "@lsp.type" { bg = "light_red" }, -- unknown group

        -- Plugin defined and custom groups

        TrailingWhitespace { fg = light_red, gui = "reverse" },

        RedSign { fg = red, gui = "reverse" },
        OrangeSign { fg = orange, gui = "reverse" },
        YellowSign { fg = yellow, gui = "reverse" },
        GreenSign { fg = green, gui = "reverse" },
        AquaSign { fg = aqua, gui = "reverse" },
        BlueSign { fg = blue, gui = "reverse" },
        PurpleSign { fg = dark_purple, gui = "reverse" },

        healthError { RedSign },
        healthWarning { YellowSign },
        healthSuccess { GreenSign },

        DiffAdd { fg = green.lighten(30).de(30), gui = "reverse" },
        DiffChange { bg = dark2 },
        DiffDelete { fg = light_red, gui = "reverse" },
        DiffText { YellowSign },

        GitSignsAdd { SignColumn, fg = green },
        GitSignsChange { SignColumn, fg = yellow },
        GitSignsDelete { SignColumn, fg = red },
        GitSignsCurrentLineBlame { NonText },

        markdownCode { fg = blue },
        xmlTag { Special },

        SnippetPlaceholder { fg = light1, bg = dark1, gui = "italic" },
        CmpItemAbbrDeprecated { fg = dark_blue.darken(30), gui = "strikethrough" },
        CmpItemAbbrMatch { fg = blue, gui = "bold" },
        CmpItemAbbrMatchFuzzy { fg = dark_blue, gui = "bold" },
        CmpItemMenu { fg = dark_purple, gui = "italic" },

        CmpItemKindField { fg = light1, bg = dark_red },
        CmpItemKindProperty { CmpItemKindField },
        CmpItemKindEvent { CmpItemKindField },

        CmpItemKindFunction { fg = light1, bg = dark_purple },
        CmpItemKindStruct { CmpItemKindFunction },
        CmpItemKindClass { CmpItemKindFunction },
        CmpItemKindModule { CmpItemKindFunction },
        CmpItemKindOperator { CmpItemKindFunction },

        CmpItemKindText { fg = light1, bg = dark_green },
        CmpItemKindEnum { CmpItemKindText },
        CmpItemKindKeyword { CmpItemKindText },

        CmpItemKindInterface { fg = light1, bg = dark_aqua },
        CmpItemKindColor { CmpItemKindInterface },
        CmpItemKindTypeParameter { CmpItemKindInterface },

        CmpItemKindVariable { fg = light1, bg = blue },
        CmpItemKindFile { CmpItemKindVariable },

        CmpItemKindMethod { fg = light1, bg = dark_blue },
        CmpItemKindValue { CmpItemKindMethod },
        CmpItemKindEnumMember { CmpItemKindMethod },

        CmpItemKindConstant { fg = dark1, bg = yellow },
        CmpItemKindConstructor { CmpItemKindConstant },
        CmpItemKindReference { CmpItemKindConstant },

        CmpItemKindUnit { fg = dark1, bg = dark_yellow },
        CmpItemKindSnippet { CmpItemKindUnit },
        CmpItemKindFolder { CmpItemKindUnit },
    }
end)
