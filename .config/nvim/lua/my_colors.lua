local lush = require "lush"
local hsl = lush.hsl
-- :command SynID  echo synIDattr(synID(line("."), col("."), 1), "name")
-- :lua require('lush').export_to_buffer(require('my_colors'))

local light0 = hsl "#fbf1c7"
local light1 = hsl "#ebdbb2"
local light2 = hsl "#d5c4a1"
local light3 = hsl "#bdae93"
local light4 = hsl "#a89984"
local gray = hsl "#928374"
local dark4 = hsl "#7c6f64"
local dark3 = hsl "#665c54"
local dark2 = hsl "#504945"
local dark1 = hsl "#3c3836"
local dark0 = hsl "#161616"
local red = hsl "#fb4934"
local dark_red = hsl "#cc241d"
local green = hsl "#b8bb26"
local dark_green = hsl "#98971a"
local yellow = hsl "#fabd2f"
local dark_yellow = hsl "#d79921"
local blue = hsl "#83a598"
local dark_blue = hsl "#458588"
local purple = hsl "#d3869b"
local dark_purple = hsl "#b16286"
local aqua = hsl "#8ec07c"
local dark_aqua = hsl "#689d6a"
local orange = hsl "#fe8019"
local dark_orange = hsl "#d65d0e"
local inv = "reverse"
local it = "italic"
local bold = "bold"
local line = "underline"
local wiggle = "undercurl"

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
return lush(function()
    return {
        Normal { fg = light1, bg = dark0 },
        Comment { fg = gray, gui = it },
        SignColumn { bg = dark1 },
        NonText { fg = dark2 },
        Search { fg = yellow, gui = inv },
        IncSearch { fg = orange, gui = inv },
        LineNr { fg = gray },
        CursorLineNr { fg = yellow },
        MatchParen { bg = dark3, gui = bold },
        Visual { bg = dark3, gui = inv },
        VisualNOS { Visual },
        TermCursorNC { fg = light3, gui = inv },
        WarningMsg { fg = red, gui = bold },
        ErrorMsg { WarningMsg, gui = bold .. "," .. inv },
        VertSplit { fg = dark3 },
        MsgArea { Normal },
        ModeMsg { fg = yellow, gui = bold },
        MoreMsg { ModeMsg },
        Pmenu { bg = dark1 },
        PmenuSel { fg = dark1, bg = blue, gui = bold },
        WildMenu { PmenuSel, gui = bold .. "," .. inv },
        PmenuSbar { bg = dark1 },
        PmenuThumb { bg = dark4 },
        Question { fg = orange, gui = bold },
        SpecialKey { fg = light4 },
        StatusLine { fg = light4, gui = bold .. "," .. inv },
        StatusLineNC { bg = dark2 },
        StatusLineModified { bg = dark_purple.darken(50) },
        TabLineSel { bg = dark2 },
        TabLine {},
        TabLineFill {},
        Title { fg = green, gui = bold },
        Directory { Title },
        Underlined { gui = line },
        Bold { gui = bold },
        Italic { gui = it },
        Error { fg = red, gui = bold .. "," .. line },
        Todo { fg = light0, gui = bold .. "," .. it },

        String { fg = green },
        Constant { fg = purple },
        -- Character Number Boolean Float
        Identifier { fg = blue },
        Function { fg = green, gui = bold },
        -- Function { Normal }, -- (use while tweaking)
        Statement { fg = red },
        -- Conditional Repeat Label Keyword Exception
        Operator { Normal },
        PreProc { fg = aqua },
        -- Include Define Macro Precondit
        Type { fg = yellow },
        -- Typedef
        StorageClass { fg = orange },
        Structure { fg = aqua },
        Special { fg = orange },
        -- Delimiter SpecialComment
        SpecialChar { fg = red },
        Tag { fg = aqua, gui = bold },
        Debug { fg = red },

        LspDiagnosticsDefaultError { fg = red },
        LspDiagnosticsDefaultWarning { fg = yellow },
        LspDiagnosticsDefaultInformation { fg = blue },
        LspDiagnosticsDefaultHint { fg = aqua },
        LspDiagnosticsUnderlineError { sp = red, gui = wiggle },
        LspDiagnosticsUnderlineWarning { sp = yellow, gui = wiggle },
        LspDiagnosticsUnderlineInformation { sp = blue, gui = wiggle },
        LspDiagnosticsUnderlineHint { sp = aqua, gui = wiggle },
        LspDiagnosticsSignError { SignColumn, fg = red },
        LspDiagnosticsSignWarning { SignColumn, fg = yellow },
        LspDiagnosticsSignInformation { SignColumn, fg = blue },
        LspDiagnosticsSignHint { SignColumn, fg = aqua },
        -- VirtualText Floating (with the 4 level variants)
        LspCodeLens { fg = gray },
        LspReferenceText { bg = dark1 },
        LspReferenceRead { LspReferenceText },
        LspReferenceWrite { LspReferenceText },

        -- TODO: Add treesitter

        RedSign { fg = red, gui = inv },
        OrangeSign { fg = orange, gui = inv },
        YellowSign { fg = yellow, gui = inv },
        GreenSign { fg = green, gui = inv },
        AquaSign { fg = aqua, gui = inv },
        BlueSign { fg = blue, gui = inv },
        PurpleSign { fg = dark_purple, gui = inv },

        healthError { RedSign },
        healthWarning { YellowSign },
        healthSuccess { GreenSign },

        DiffAdd { fg = green.lighten(30).de(30), gui = inv },
        DiffChange { bg = dark2 },
        DiffDelete { fg = red.lighten(30).de(30), gui = inv },
        DiffText { YellowSign },

        GitSignsAdd { SignColumn, fg = green },
        GitSignsChange { SignColumn, fg = yellow },
        GitSignsDelete { SignColumn, fg = red },
        GitSignsCurrentLineBlame { NonText },

        markdownCode { fg = blue },
        xmlTag { Special },
    }
end)
