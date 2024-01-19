local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.font = wezterm.font 'JetBrainsMonoNL Nerd Font Mono'
config.hide_tab_bar_if_only_one_tab = true
config.enable_wayland = true
config.enable_scroll_bar = false
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_gradient = {
    orientation = 'Vertical',
    colors = {
        '#020024',
        '#094873',
        '#032229',
    },
}

config.keys = {
    {key = 'c', mods = 'CMD|SHIFT', action = act.CopyTo 'Clipboard'},
    {key = 'v', mods = 'CMD|SHIFT', action = act.PasteFrom 'Clipboard'},
}

return config
