-- Converted from hyprland.conf (hyprlang) for Hyprland 0.57 Lua config.
-- The original hyprland.conf is kept beside this file for reference.

------------------
---- MONITORS ----
------------------
-- Layout (logical coords after scaling):
--   DP-1 (middle, 4K UW) : 2560x1440 @ 1.6 -> 1600x900 at 0,0
--   DP-2 (left, 4K)      : 3840x2160 @ 2.0 -> 1920x1080 at -1920,0
--   HDMI-A-1 (right, rotated 90 CCW): 1920x1080 -> 1080x1920 at 1600,0
--   HDMI-A-2 (aux): 1360x768 above DP-2, right edge aligned to DP-1's left edge (X=0)
hl.monitor({ output = "DP-1",     mode = "2560x1440@59.95", position = "0x0",        scale = 1.6 })
hl.monitor({ output = "DP-2",     mode = "3840x2160@29.98", position = "-1920x0",    scale = 2.0 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080",       position = "1600x0",     scale = 1, transform = 1 })
hl.monitor({ output = "HDMI-A-2", mode = "1360x768",        position = "-1360x-768", scale = 1 })

hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-2" })

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "terminator"
local fileManager = "nemo"
local menu        = "wofi --show drun"
local rofiTheme   = "~/.config/rofi/themes/hacker-green.rasi"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE && systemctl --user start hyprland-session.target")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")

-- NVIDIA primary, Intel iGPU secondary (by-path IDs are stable across reboots)
hl.env("WLR_DRM_DEVICES", "/dev/dri/by-path/pci-0000:01:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card")

-- NVIDIA GPU acceleration
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")

-- XWayland scaling: highest scale (2.0) so apps are sharp everywhere
hl.env("GDK_SCALE", "2")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.config({
    cursor   = { no_hardware_cursors = false },
    render   = { direct_scanout = true },
    xwayland = { force_zero_scaling = true },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 12,
        border_size = 0,
        resize_on_border = true,
        extend_border_grab_area = 15,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled        = false,
            range          = 20,
            render_power   = 3,
            color          = "rgba(00ff4140)",
            color_inactive = "rgba(00000060)",
            offset         = "0 0",
            scale          = 1.0,
        },

        blur = {
            enabled           = false,
            size              = 6,
            passes            = 2,
            new_optimizations = true,
            noise             = 0.02,
            contrast          = 1.1,
            brightness        = 0.65,
            vibrancy          = 0.3,
            vibrancy_darkness = 0.6,
            special           = true,
            popups            = true,
            popups_ignorealpha = 0.2,
            xray              = false,
        },

        dim_inactive = false,
        dim_strength = 0,
    },

    animations = { enabled = false },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },

    master = { new_status = "master" },

    group = {
        col = {
            border_active          = { colors = { "rgba(00ff41ee)", "rgba(39ff14ee)" }, angle = 45 },
            border_inactive        = "rgba(00ff4115)",
            border_locked_active   = "rgba(00ff41aa)",
            border_locked_inactive = "rgba(00ff4115)",
        },
        groupbar = {
            enabled     = true,
            font_family = "JetBrainsMono Nerd Font Mono",
            font_size   = 10,
            height      = 18,
            col = {
                active   = "rgba(00ff4140)",
                inactive = "rgba(050a0580)",
            },
            text_color = "rgba(00ff41ff)",
            gaps_in    = 2,
            gaps_out   = 2,
            rounding   = 0,
        },
    },

    misc = {
        force_default_wallpaper     = 0,
        disable_hyprland_logo       = true,
        disable_splash_rendering    = true,
        background_color            = "0x000000",
        animate_manual_resizes      = false,
        animate_mouse_windowdragging = false,
        focus_on_activate           = true,
    },

    debug = { suppress_errors = true },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        repeat_delay = 200,
        repeat_rate  = 175,
        sensitivity  = 0,
        touchpad = { natural_scroll = false },
    },
})

-- Animation curves and leaves are kept for easy re-enable; inert while animations.enabled = false.
hl.curve("silky",    { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05} } })
hl.curve("spring",   { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.1} } })
hl.curve("whip",     { type = "bezier", points = { {0.22, 1.2},  {0.36, 1.0} } })
hl.curve("ghost",    { type = "bezier", points = { {0.33, 0.0},  {0.0, 1.0}  } })
hl.curve("snap",     { type = "bezier", points = { {0.0, 0.85},  {0.15, 1.06} } })
hl.curve("dissolve", { type = "bezier", points = { {0.4, 0.0},   {0.8, 0.15} } })
hl.curve("bounce",   { type = "bezier", points = { {0.05, 0.95}, {0.1, 1.12} } })
hl.curve("breathe",  { type = "bezier", points = { {0.25, 0.46}, {0.45, 0.94} } })

hl.animation({ leaf = "windowsIn",        enabled = true, speed = 5,  bezier = "spring",   style = "popin 15%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,  bezier = "dissolve", style = "popin 85%" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 4,  bezier = "whip" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 5,  bezier = "silky",    style = "slidefade 40%" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 4,  bezier = "silky",    style = "slidefade -40%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5,  bezier = "bounce",   style = "slidefadevert -40%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 4,  bezier = "ghost" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 3,  bezier = "dissolve" })
hl.animation({ leaf = "fadeSwitch",       enabled = true, speed = 3,  bezier = "breathe" })
hl.animation({ leaf = "fadeDim",          enabled = true, speed = 4,  bezier = "breathe" })
hl.animation({ leaf = "fadeShadow",       enabled = true, speed = 5,  bezier = "ghost" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,  bezier = "snap",     style = "popin 80%" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 2,  bezier = "dissolve", style = "popin 80%" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 3,  bezier = "ghost" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 2,  bezier = "dissolve" })
hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "breathe" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 60, bezier = "breathe" })

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Window/session actions
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind("ALT + F4",                hl.dsp.window.close())
hl.bind(mainMod .. " + return",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + delete",    hl.dsp.exit())
hl.bind(mainMod .. " + W",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G",         hl.dsp.group.toggle())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + ALT + F",   hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd('swaylock --screenshots --clock --indicator --indicator-radius 120 --indicator-thickness 8 --effect-blur 15x5 --effect-vignette 0.5:0.5 --ring-color 00ff41 --key-hl-color 39ff14 --line-color 00000000 --inside-color 050a0588 --separator-color 00ff4130 --text-color 00ff41 --font "JetBrainsMono Nerd Font Mono" --grace 3'))
hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd("killall waybar || waybar"))

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces: switch with mainMod + [0-9], move window with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + grave",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with the mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Rofi
hl.bind("SUPER + SPACE",  hl.dsp.exec_cmd("rofi -show drun -theme " .. rofiTheme))
hl.bind("SUPER + R",      hl.dsp.exec_cmd("rofi -show run -theme " .. rofiTheme))
hl.bind("ALT + Tab",      hl.dsp.exec_cmd("rofi -show window -theme " .. rofiTheme))
hl.bind("SUPER + period", hl.dsp.exec_cmd("rofi -modi emoji -show emoji -theme " .. rofiTheme))
hl.bind("SUPER + equal",  hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort -theme " .. rofiTheme))

-- Screenshots
hl.bind("Print",         hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh fullscreen"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh region"))
hl.bind("CTRL + Print",  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh window"))
hl.bind("ALT + Print",   hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh edit"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh quick"))
hl.bind("SUPER + S",         hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh region"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh fullscreen"))
hl.bind("SUPER + CTRL + S",  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh window"))
hl.bind("SUPER + ALT + S",   hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh edit"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot-menu.sh"))

-- Clipboard history
hl.bind("SUPER + V",         hl.dsp.exec_cmd('cliphist list | rofi -dmenu -p "Clipboard" -theme ' .. rofiTheme .. ' | cliphist decode | wl-copy'))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd('cliphist wipe && notify-send "Clipboard" "History cleared"'))
hl.bind("SUPER + CTRL + C",  hl.dsp.exec_cmd("wl-copy --clear"))
hl.bind("SUPER + ALT + V",   hl.dsp.exec_cmd('cliphist list | rofi -dmenu -p "Delete Entry" -theme ' .. rofiTheme .. ' | cliphist delete'))

---------------------
---- LAYER RULES ----
---------------------
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, blur_popups = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "rofi" },   blur = true, blur_popups = true, ignore_alpha = 0.2, dim_around = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" },      blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "notifications" },              blur = true, ignore_alpha = 0.3 })

----------------------
---- WINDOW RULES ----
----------------------
local opaque = "1.0 override 1.0 override"

-- Float dialogs, file pickers, popups
for _, t in ipairs({ "Open File", "Save File", "Open Folder", "Select a File", "Choose wallpaper", "File Upload", "Library", "Volume Control" }) do
    hl.window_rule({ match = { title = "^(" .. t .. ")(.*)$" }, float = true })
end
for _, c in ipairs({ "pavucontrol", "nm-connection-editor", "blueman-manager", "nwg-look", "qt5ct", "qt6ct", "org.kde.polkit-kde-authentication-agent-1" }) do
    hl.window_rule({ match = { class = "^(" .. c .. ")$" }, float = true })
end

-- Screen-share source picker: pinned to DP-1 (non-rotated), floating, centered, fixed size
hl.window_rule({
    name  = "share-picker",
    match = { class = "^(hyprland-share-picker)$" },
    float = true, size = "760 560", center = true, monitor = "DP-1", workspace = "2",
})

hl.window_rule({ match = { class = "^(NONEXISTENT)$" }, no_initial_focus = true })

-- Picture in picture: always on top, small, corner
hl.window_rule({
    name  = "pip",
    match = { title = "^(Picture-in-Picture)$" },
    float = true, size = "480 270", pin = true, move = "100%-490 100%-280", opacity = opaque,
})

-- Fully opaque apps
hl.window_rule({ match = { class = "^(firefox)$", fullscreen = true }, opacity = opaque })
hl.window_rule({ match = { title = "^(.*YouTube.*)$", fullscreen = true }, opacity = opaque })
for _, c in ipairs({ "mpv", "vlc", "com.obsproject.Studio", "Code", "code-url-handler", "jetbrains-.*", "terminator" }) do
    hl.window_rule({ match = { class = "^(" .. c .. ")$" }, opacity = opaque })
end
