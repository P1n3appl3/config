local w = require "wezterm"
local a = w.action
local c = {
    front_end = "WebGpu",
    default_prog = { "zsh" },
    font = w.font "Source Code Pro",
    font_rules = {
        {
            intensity = "Bold",
            italic = true,
            font = w.font { family = "Source Code Pro", weight = "Bold", style = "Italic" },
        },
        {
            intensity = "Bold",
            font = w.font { family = "Source Code Pro", weight = "Bold" },
        },
    },
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    color_scheme = "iTerm2 Default",
    colors = { foreground = "#DDDDDD" },
    default_cursor_style = "BlinkingBar",
    hide_tab_bar_if_only_one_tab = true,
    enable_kitty_keyboard = true,
}

local h = w.hostname()
if h == "WOPR" then c.font_size = 15 end

local function get_zone_around_cursor(pane)
    local cursor = pane:get_cursor_position()
    print(cursor)
    local zone = pane:get_semantic_zone_at(math.max(cursor.x - 1, 0), cursor.y)
    if zone then
        print(zone) -- return pane:get_text_from_semantic_zone(zone)
    end
    return nil
end

-- TODO: semantic zone in pager
w.on("view-zone-in-pager", function(window, _pane)
    print(window:current_event())
    -- get_zone_around_cursor(pane)
end)

w.on("view-history-in-pager", function(window, pane)
    local text = pane:get_lines_as_escapes(pane:get_dimensions().scrollback_rows)

    -- TODO: mkfifo or something to avoid writing tmpfile?
    local name = os.tmpname()
    local f = io.open(name, "w+")
    f:write(text)
    f:flush()
    f:close()

    window:perform_action(a.SpawnCommandInNewTab { args = { "less", "-R", name } }, pane)
    w.sleep_ms(5000)
    os.remove(name)
end)

c.disable_default_key_bindings = true
local m = "CTRL|SHIFT"
c.keys = {
    { mods = m, key = "c", action = a.CopyTo "Clipboard" },
    { mods = m, key = "v", action = a.PasteFrom "Clipboard" },
    { mods = m, key = "+", action = a.IncreaseFontSize },
    { mods = m, key = "_", action = a.DecreaseFontSize },
    { mods = m, key = ")", action = a.ResetFontSize },
    { mods = m, key = "r", action = a.ReloadConfiguration },
    { mods = m, key = "u", action = a.ScrollByPage(-1) },
    { mods = m, key = "d", action = a.ScrollByPage(1) },
    { key = "PageUp", action = a.ScrollToPrompt(-1) },
    { key = "PageDown", action = a.ScrollToPrompt(1) },
    { mods = m, key = "Space", action = a.QuickSelect },
    { mods = m, key = "h", action = a.EmitEvent "view-history-in-pager" },
    { mods = m, key = "~", action = a.ShowDebugOverlay },
    { mods = "ALT", key = "r", action = a.ShowLauncher },
}

local l = { streak = 1, button = "Left" }
local r = { streak = 1, button = "Right" }
c.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "NONE",
        alt_screen = false,
        action = a.ScrollByLine(-1),
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "NONE",
        alt_screen = false,
        action = a.ScrollByLine(1),
    },
    {
        event = { Down = { streak = 4, button = "Left" } },
        action = a.SelectTextAtMouseCursor "SemanticZone",
        mods = "NONE",
    },
    { event = { Down = l }, mods = m, action = a.Nop },
    { event = { Up = l }, mods = m, action = a.OpenLinkAtMouseCursor },
    {
        event = { Down = r },
        mods = m,
        alt_screen = false,
        action = a.EmitEvent "view-zone-in-pager",
    },
    { event = { Down = { streak = 1, button = "Middle" } }, action = a.Nop },
    { event = { Up = { streak = 1, button = "Left" } }, action = a.Nop },
    { event = { Up = { streak = 2, button = "Left" } }, action = a.Nop },
    { event = { Up = { streak = 3, button = "Left" } }, action = a.Nop },
}

return c
