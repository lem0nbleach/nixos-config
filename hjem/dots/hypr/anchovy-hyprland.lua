-- Hyprland configuration for anchovy (laptop)
-- Lua config (Hyprland 0.55.4). Translated from anchovy-hyprland.conf.
-- Laptop-specific: eDP-1 only, touchpad scroll factor, tearing on, shadows off,
-- brightness/volume/media keys, battery readout.

local fileManager = "foot -e yazi"
local mainMod     = "SUPER"
local menu        = "hyprlauncher"
local terminal    = "foot"

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1920@120",
    position = "0x0",
    scale    = 1.6,
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("HYPRCURSOR_THEME", "bibata-hyprcursor")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-------------------
---- LOOK/FEEL ----
-------------------

hl.config({
    general = {
        allow_tearing    = true,
        border_size      = 2,
        gaps_in          = 2,
        gaps_out         = 4,
        layout           = "dwindle",
        resize_on_border = false,

        col = {
            active_border   = "rgb(FFB900)",
            inactive_border = "rgb(45475A)",
        },
    },

    decoration = {
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        rounding         = 10,

        -- laptop: no drop shadows
        shadow = {
            enabled = false,
        },

        blur = {
            brightness = 0.8,
            contrast   = 0.7,
            enabled    = true,
            passes     = 3,
            size       = 5,
            special    = true,
            vibrancy   = 0.2,
            xray       = true,
        },
    },

    group = {
        col = {
            border_active        = "rgb(89B4FA)",
            border_inactive      = "rgb(45475A)",
            border_locked_active = "rgb(94E2D5)",
        },
        groupbar = {
            col = {
                active   = "rgb(89B4FA)",
                inactive = "rgb(45475A)",
            },
            text_color = "rgb(CDD6F4)",
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        background_color         = "rgb(1E1E2E)",
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        vrr                      = 3,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        accel_profile = "flat",
        follow_mouse  = 1,
        kb_layout     = "us",
        sensitivity   = 0,

        touchpad = {
            scroll_factor = 0.5,
        },
    },
})

------------------
---- ANIMATIONS ----
------------------

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 2,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-----------------
---- AUTOSTART ----
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("hyprctl setcursor bibata-hyprcursor 24")
    hl.exec_cmd("mkdir -p /home/lem0nbleach/logs && hyprpaper > /home/lem0nbleach/logs/hyprpaper_log.txt")
    hl.exec_cmd("hypridle > /home/lem0nbleach/logs/hypridle_log.txt")
    hl.exec_cmd("hyprlauncher -d")
    hl.exec_cmd("hyprsunset --gamma 100% --identity")
    hl.exec_cmd("stash watch")
    hl.exec_cmd("fcitx5 -d -r")
    hl.exec_cmd("fcitx5-remote -r")
    -- Session apps: both live in the scratchpad (no Jellyfin on the laptop)
    hl.exec_cmd("vesktop")
    hl.exec_cmd("todoist-electron")
end)

-----------------
---- KEYBINDS ----
-----------------

hl.bind(mainMod .. " + code:59", hl.dsp.exec_cmd("hyprshutdown -t 'Shutting down' --post-cmd 'systemctl poweroff'"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("hyprpicker -a -f hex"))

for i = 1, 6 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("scratchPad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchPad" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | stash-copy"))

hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- laptop hardware keys
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })

hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })

hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })

hl.bind(mainMod .. " + code:61", hl.dsp.exec_cmd("notify-send \"Battery Level: $(cat /sys/class/power_supply/BAT1/capacity)%\""))

--------------------------
---- WINDOW RULES ----
--------------------------

hl.window_rule({
    name  = "fullscreen-no-idle",
    match = { fullscreen_state_client = 2 },
    idle_inhibit = "always",
})

hl.window_rule({
    name  = "vesktop-in-scratchpad",
    match = { class = "[Vv]esktop" },
    workspace = "special:scratchPad silent",
})

hl.window_rule({
    name  = "todoist-in-scratchpad",
    match = { class = "[Tt]odoist" },
    workspace = "special:scratchPad silent",
})

hl.window_rule({
    name  = "focus-discord",
    match = { class = "vesktop", initial_title = "Discord" },
    focus_on_activate = true,
})

hl.window_rule({
    name  = "focus-firefox",
    match = { class = "firefox", initial_title = "Mozilla Firefox" },
    focus_on_activate = true,
})
