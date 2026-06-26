require("conf.binds")
require("conf.env")
require("conf.monitors")
require("conf.rules")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("nextcloud --background")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("quickshell -c lg")
    hl.exec_cmd("kitty --session sessions/main", { workspace = 1 })
    hl.exec_cmd("cursor-clip --daemon")
    hl.exec_cmd("hyprctl setcursor WinSur-dark-cursors 24")
    hl.exec_cmd("batsignal -b -w 20 -c 10 -d 5")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11")
    hl.exec_cmd("kdeconnectd")
end)

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        follow_mouse = 2,
        sensitivity = 0.6, -- -1.0 - 1.0, 0 means no modification.
        scroll_factor = 1.5,

        repeat_rate = 30,
        repeat_delay = 250,

        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.6,
            clickfinger_behavior = true,
            disable_while_typing = true,
        },

        kb_options = "compose:ralt",
    },

    cursor = {
        no_hardware_cursors = 1,
        no_warps = true,
    },

    general = {
        gaps_in = 5,
        gaps_out = 10,
        layout = "master",
        allow_tearing = true,
        resize_on_border = true,

        border_size = 1,
        col = {
            inactive_border = "0xee444444",
            active_border = "0xee666666",
        },
    },

    layout = {
        single_window_aspect_ratio = { 13, 8 },
        single_window_aspect_ratio_tolerance = 0,
    },

    decoration = {
        rounding = 15,

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            popups = true,
            popups_ignorealpha = 0.1,
        },

        shadow = {
            enabled = false,
        },

        -- glow = {
        --     enabled = true,
        --     color = "0x66666644",
        --     range = 6,
        -- },
    },

    animations = {
        enabled = true,
    },

    master = {
        new_status = "slave",
        mfact = 0.5,
        slave_count_for_center_master = 0,
    },

    gestures = {
        workspace_swipe_invert = false,
        workspace_swipe_cancel_ratio = 0.25,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = true,
    },
})

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "layers", enabled = true, speed = 2, style = "fade", bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, style = "slide", bezier = "default" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace", scale = 0.35 })
