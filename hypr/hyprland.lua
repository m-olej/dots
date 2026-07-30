-- =========================================================
-- Environment Variables & Startup
-- =========================================================
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("NIXOS_OZONE_WL", "1")
hl.env("GDK_SCALE", "1")
hl.env("GDK_DPI_SCALE", "1")
hl.env("XCURSOR_SIZE", "24")

require("aesthetic")

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start graphical-session.target")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Andromeda")
    hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences theme Andromeda")
end)

-- =========================================================
-- Hardware & Peripherals
-- =========================================================
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto"
})

hl.config({
    input = {
        kb_layout = "us,pl",
        kb_options = "grp:win_space_toggle",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.2
        }
    },
    -- Lock Asus stylus to eDP-1
    device = {
        {
            name = "wdht1f01:00-2575:0911-stylus",
            output = "eDP-1"
        }
    },
    xwayland = {
        force_zero_scaling = true
    },
    dwindle = {
        preserve_split = true
    }
})

-- =========================================================
-- Window & Layer Rules
-- =========================================================
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = "^(code-url-handler)$" }, opacity = "0.85 override" })
hl.window_rule({ match = { class = "^(kitty)$" }, opacity = "0.85 override" })

-- TUI apps
hl.window_rule({ match = { class = "^(float_tui)$" }, float = true, dim_around = true, size = "(monitor_w*0.7) (monitor_h*0.6)", center = true })

-- KDE Connect
hl.window_rule({ match = { class = "^(.*kdeconnect.*)$" }, float = true, center = true, size = "400 150", opacity = "0.85 override", rounding = 12 })

-- Steam Notification Fix
hl.window_rule({
    match = { class = "^(steam)$", title = "^(notificationtoasts_.*_desktop)$" },
    float = true,
    pin = true,
    move = "100%-w-20 100%-w-20"
})

-- Layer rules for Waybar
hl.layer_rule({ match = { namespace = "^waybar$" }, blur = true, ignore_alpha = 0.1 })

-- =========================================================
-- Keybindings & Variables
-- =========================================================
local mod = "SUPER"
local terminal = "kitty"
local editor = "nvim"
local fileManager = "nautilus"
local appLauncher = "~/.config/rofi/app_launcher.sh"
local clipboard = "~/.config/rofi/clipboard_launcher.sh"
local wallpaper = "~/.config/hypr/scripts/wallpaper_switch.sh"
local monitors = "~/.config/hypr/scripts/monitors.py"
local resetScript = "~/.config/hypr/scripts/input_reset.sh"

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(appLauncher))
hl.bind(mod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(wallpaper))
hl.bind(mod .. " + M", hl.dsp.exec_cmd(monitors))
hl.bind(mod .. " + BACKSPACE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd(resetScript))
hl.bind(mod .. "+ SHIFT + CTRL + M", hl.dsp.exit())

-- Dwindle Layout
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + L", hl.dsp.layout("swapsplit"))
hl.bind(mod .. " + K", hl.dsp.window.float({ action = "toggle" }))

-- Move Focus
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Workspaces
-- Because it's Lua, we can loop through our numbered workspaces natively!
for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i)}))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Move window around
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Scroll Workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + up", hl.dsp.focus({ workspace = "e+1" }))

-- Special Workspaces
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("browser"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:browser" }))
hl.bind(mod .. " + X", hl.dsp.workspace.toggle_special("terminal"))
hl.bind(mod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:terminal" }))

-- Mouse Binds (Flags go into a table as the third argument)
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd([[grim - | wl-copy && notify-send "📸 Screenshot Taken" "Full screen copied to clipboard" -u normal -t 3000]]))
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy && notify-send "📸 Region Captured" "Copied to clipboard" -u normal -t 3000]]))
hl.bind("ALT + CTRL + S", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | swappy -f -]]))

-- Audio & Brightness (Repeating flag handles continuous holding)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true })

-- =========================================================
-- Submaps
-- =========================================================
-- Resize Submap (Bind entering the submap, then define the submap logic)
hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    -- Binde equivalents are mapped using the `repeating = true` flag
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    -- Escape logic to exit the submap and return to default
    hl.bind("escape", hl.dsp.submap("reset"))
end)
