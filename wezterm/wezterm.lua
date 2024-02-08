local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.term = "wezterm"

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.hide_tab_bar_if_only_one_tab = true
config.enable_wayland = true
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_gradient = {
    orientation = "Vertical",
    colors = {
        "#0e0f13",
        "#14161c",
        "#0e0f13",
    },
}
-- config.text_background_opacity = 0.7
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
config.color_scheme = "OneDark (base16)"

config.front_end = "OpenGL"

config.keys = {
    { key = "c", mods = "CMD|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CMD|SHIFT", action = act.PasteFrom("Clipboard") },
    { key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
}

return config
