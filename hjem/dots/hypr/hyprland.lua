-- Hyprland configuration for croaker
-- Lua config (Hyprland 0.55.4, nixpkgs 26.05). Translated from the old hyprlang file.

local fileManager = "foot -e yazi"
local mainMod     = "SUPER"
local menu        = "hyprlauncher"
local terminal    = "foot"

------------------------------
---- MONITORS / WORKSPACES ----
------------------------------

hl.monitor({
    output   = "DP-2",
    mode     = "2560x1440@144",
    position = "0x0",
    scale    = 1,
    vrr      = 3,
})

hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@60",
    position  = "-1080x0",
    scale     = 1,
    transform = 1,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "name:Secondary", monitor = "HDMI-A-1", default = true })

for i = 2, 6 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2" })
end

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
        allow_tearing    = false,
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

        shadow = {
            color        = "rgba(1a1a1aee)",
            enabled      = true,
            range        = 10,
            render_power = 3,
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
        background_color        = "rgb(1E1E2E)",
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        vrr                     = 3,
    },

    input = {
        accel_profile = "flat",
        follow_mouse  = 1,
        kb_layout     = "us",
        sensitivity   = 0,
    },
})

hl.device({
    name      = "wacom-cintiq-16-pen",
    output    = "HDMI-A-1",
    transform = 0,
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
    -- 0.55.4 does not start this itself; the target pulls in graphical-session.target
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("hyprctl setcursor bibata-hyprcursor 24")
    hl.exec_cmd("hyprpaper > /home/lem0nbleach/logs/hypr/hyprpaper.log")
    hl.exec_cmd("setpriv --ambient-caps -all hyprlauncher -d")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprsunset --gamma 100% --identity")
    hl.exec_cmd("stash watch --expire-after 24h")
    hl.exec_cmd("fcitx5 -d -r")
    hl.exec_cmd("fcitx5-remote -r")
    hl.exec_cmd("easyeffects -w")
    -- Session apps: Todoist on the HDMI output, Vesktop + Jellyfin in the scratchpad
    hl.exec_cmd("todoist-electron")
    hl.exec_cmd("vesktop")
    hl.exec_cmd("jellyfin-desktop")
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

for i = 1, 6 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("scratchPad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchPad" }))
hl.bind(mainMod .. " + X",         hl.dsp.focus({ workspace = "name:Secondary" }))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "name:Secondary" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | stash store"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

--------------------------
---- WINDOW RULES ----
--------------------------

hl.window_rule({
    name  = "fullscreen-no-idle",
    match = { fullscreen_state_client = 2 },
    idle_inhibit = "always",
})

-- Startup placement
hl.window_rule({
    name  = "todoist-on-hdmi",
    match = { class = "[Tt]odoist" },
    workspace = "name:Secondary silent",
})

hl.window_rule({
    name  = "vesktop-in-scratchpad",
    match = { class = "[Vv]esktop" },
    workspace = "special:scratchPad silent",
})

hl.window_rule({
    name  = "jellyfin-in-scratchpad",
    match = { class = "org\\.jellyfin\\.JellyfinDesktop|[Jj]ellyfin" },
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
