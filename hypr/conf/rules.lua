hl.window_rule({
    name = "floats",
    match = {
        class = "(org.gnome.NautilusPreviewer|xdg-desktop-portal-gtk|Emulator)",
    },
    float = true,
})

hl.layer_rule({
    name = "dropdown",
    match = { namespace = "kitty-quick-access" },
    animation = "slide top",
})

hl.layer_rule({
    name = "blur and alpha",
    match = { class = ".*" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.1,
})

hl.layer_rule({
    name = "selection",
    match = { namespace = "selection" },
    blur = false,
    no_anim = true,
})
