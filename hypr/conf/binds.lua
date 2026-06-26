local mainMod = "META"
local scriptDir = "$HOME/.config/hypr/scripts"

local function resize(x, y)
    return { x = x, y = y, relative = true }
end

local repeating = { repeating = true }

hl.bind("CONTROL + SHIFT + return", hl.dsp.exec_cmd("kitty --session sessions/main"))
hl.bind(mainMod .. " + SHIFT + r", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CONTROL + SHIFT + w", hl.dsp.window.close())
hl.bind("CONTROL + ALT + escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("CONTROL + ALT + q", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("CONTROL + SHIFT + x", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. "+ f", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + p", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("CONTROL + space", hl.dsp.exec_cmd("fuzzel"))
hl.bind("CONTROL + ALT + V", hl.dsp.exec_cmd("cursor-clip"))
hl.bind("CONTROL + SHIFT + d", hl.dsp.exec_cmd("hyprctl dpms on"))

hl.bind("ALT+ TAB", hl.dsp.focus({ last = true }))
hl.bind(mainMod .. " + return", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + m", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + m", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("ALT + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("ALT + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("ALT + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("ALT + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("ALT + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("ALT + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("ALT + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("ALT + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("ALT + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind("ALT + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind("ALT + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind("ALT + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind("ALT + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind("ALT + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind("ALT + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind("ALT + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind("ALT + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind("ALT + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind("ALT + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

hl.bind(mainMod .. " + e", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize(resize(10, 0)), repeating)
    hl.bind("h", hl.dsp.window.resize(resize(-10, 0)), repeating)
    hl.bind("k", hl.dsp.window.resize(resize(0, 10)), repeating)
    hl.bind("j", hl.dsp.window.resize(resize(0, -10)), repeating)
    hl.bind("SHIFT + l", hl.dsp.window.resize(resize(20, 0)), repeating)
    hl.bind("SHIFT + h", hl.dsp.window.resize(resize(-20, 0)), repeating)
    hl.bind("SHIFT + k", hl.dsp.window.resize(resize(0, 20)), repeating)
    hl.bind("SHIFT + j", hl.dsp.window.resize(resize(0, -20)), repeating)
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("ALT + T", hl.dsp.exec_cmd("kitten quick-access-terminal --detach=yes"))
hl.bind("ALT + SHIFT + T", hl.dsp.exec_cmd("procs kitty-quick-access --json | jq -r '.[0].PID' | xargs kill -9"))

-- Screenshots
hl.bind("CONTROL + SHIFT + 3", hl.dsp.exec_cmd("hyprshot -z -o ~/Pictures/Screenshots -m output -m active"))
hl.bind("CONTROL + SHIFT + 4", hl.dsp.exec_cmd("hyprshot -z -o ~/Pictures/Screenshots -m region"))
hl.bind("CONTROL + SHIFT + 5", hl.dsp.exec_cmd("hyprshot -z -o ~/Pictures/Screenshots -m window"))

-- Media Keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(scriptDir .. "/play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptDir .. "/resync_a2dp"))
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptDir .. "/resync_hfp"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptDir .. "/volume up"), repeating)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptDir .. "/volume down"), repeating)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptDir .. "/volume mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), repeating)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), repeating)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("F24", hl.dsp.exec_cmd("voxtype record toggle"))
