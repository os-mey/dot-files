local home = os.getenv 'HOME'
local hypr = home .. '/.config/hypr'
local keyboard = 'apple-inc.-apple-internal-keyboard-/-trackpad'

-- Set default apps
local terminal = 'kitty'
local browser = 'zen-beta'
local files = terminal .. ' -e yazi'

local notifyDismiss = 'makoctl dismiss'
local notifyRestore = 'makoctl restore'

local regionscreenshot = 'hyprshot -m region -o ' .. home .. '/screenshots'
local windowscreenshot = 'hyprshot -m window -o ' .. home .. '/screenshots'

-- Reference scripts
local apps = home .. '/.local/bin/dot-launcher'
local colorpicker = home .. '/.local/bin/dot-colorpicker point'
local colorselector = home .. '/.local/bin/dot-colorpicker select'
local disks = '[float; stayfocused; size 60% 30%] ' .. terminal .. ' -e ' .. home .. '/.local/bin/dot-disks'
local logout = home .. '/.local/bin/dot-logout'
local media = home .. '/.local/bin/dot-media'
local pdfsearchcontent = home .. '/.local/bin/dot-pdf-search content'
local pdfsearchname = home .. '/.local/bin/dot-pdf-search name'
local togglebar = home .. '/.local/bin/dot-toggle-bar'

local toggleblueman = 'pkill blueman-manage || blueman-manager'
local togglebluetooth = 'bluetooth toggle'

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
hl.env('HYPRCURSOR_THEME', 'Adwaita')
hl.env('XCURSOR_SIZE', '24')
hl.env('XCURSOR_THEME', 'Adwaita')
hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')

-----------------
--- AUTOSTART ---
-----------------
hl.on('hyprland.start', function()
    hl.exec_cmd('pgrep waybar || ' .. togglebar .. ' start')
    hl.exec_cmd 'hypridle'
    hl.exec_cmd('mako --config ' .. home .. '/.config/mako/config.toml')
    hl.exec_cmd(hypr .. '/scripts/callback.sh')
    hl.exec_cmd('[workspace 1 silent] ' .. browser)
    hl.exec_cmd '[workspace special:mails silent] thunderbird'
end)

hl.on('hyprland.shutdown', function()
    hl.exec_cmd 'pkill waybar; pkill mako'
end)

----------------
--- MONITORS ---
----------------
hl.monitor {
    output = 'eDP-1',
    mode = 'preferred',
    position = '0x0',
    scale = '1.6',
}
hl.monitor {
    output = 'HDMI-A-2',
    mode = 'preferred',
    position = '-750x-1440',
    scale = '1',
    -- mirror = 'eDP-1',
}

-----------------------
--- RULES ---
-----------------------

hl.workspace_rule { workspace = 's[true]', gaps_in = 0, gaps_out = 0 }
hl.window_rule({ match = { workspace = "s[true]" }, border_size = 0, rounding = 0 })

hl.window_rule { match = { class = '^(thunderbird)$' }, workspace = 'special:mails' }

hl.window_rule { match = { class = '.*' }, idle_inhibit = 'fullscreen' }
hl.window_rule { match = { class = '.*' }, suppress_event = 'maximize' }

hl.window_rule { match = { class = '^([Ll]ibre[Oo]ffice)$' }, tile = true, opaque = true }

hl.window_rule { match = { class = '^(Mars)$', title = '^(MARS.*)$' }, tile = true }
hl.window_rule { match = { class = '^(Mars)$', title = '^(win.)$' }, center = true, min_size = '350 200' }

hl.window_rule { match = { class = '^(com-cburch-logisim-Main)$', title = '(Logisim: .*)' }, tile = true }
hl.window_rule { match = { class = '^(com-cburch-logisim-Main)$', title = '(.* Logisim-evolution.*)' }, tile = true }
hl.window_rule { match = { class = '^(com-cburch-logisim-Main)$' }, opaque = true }

hl.window_rule { match = { title = '^(Bluetooth Devices)$' }, float = true }
hl.window_rule { match = { class = '^(yad)$' }, float = true }
hl.window_rule {
    match = { class = '^(yad)$', title = '^(Media.*)$' },
    pin = true,
    no_anim = true,
    no_focus = true,
    rounding = 8,
    opacity = 0.9,
    move = '(monitor_w*0.5) (monitor_h*0.8)',
    size = '0 0',
}
hl.window_rule { match = { class = 'negative:^(yad)$', float = true }, border_size = 1 }

hl.window_rule { match = { class = '^(pdfsearch)$' }, float = true, size = '(monitor_w*0.8) (monitor_h*0.7)', opacity = 0.95 }
hl.window_rule { match = { class = '^$', title = '^$', xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true }

hl.layer_rule { match = { namespace = 'wofi' }, dim_around = true }
hl.layer_rule { match = { namespace = 'hyprpicker' }, animation = 'fade' }
hl.layer_rule { match = { namespace = 'selection' }, animation = 'fade' }
hl.layer_rule { match = { namespace = 'hyprpaper' }, no_anim = true }

---------------
--- OPTIONS ---
---------------
hl.config {
    general = {
        gaps_in = 3,
        gaps_out = 0,
        border_size = 0,
        col = {
            active_border = 'rgb(cba6f7)',
            inactive_border = 'rgb(585b70)',
        },
        resize_on_border = false,
        no_focus_fallback = true,
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        dim_inactive = false,
        dim_strength = 0.4,
        dim_around = 0.2,
        dim_special = 0.6,
        blur = { enabled = false },
        shadow = { enabled = false },
    },
    animations = {
        enabled = true,
    },
    input = {
        kb_layout = 'de,us',
        kb_variant = 'mac_nodeadkeys,colemak',
        kb_model = '',
        kb_options = 'caps:escape',
        kb_rules = '',
        repeat_delay = 400,
        repeat_rate = 30,
        follow_mouse = 1,
        sensitivity = 0,
        mouse_refocus = true,
        touchpad = {
            clickfinger_behavior = 1,
            tap_to_click = false,
            disable_while_typing = false,
            natural_scroll = true,
            scroll_factor = 0.3,
        },
    },
    misc = {
        background_color = '0x000000',
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        focus_on_activate = true,
        vrr = 1,
    },
    xwayland = {
        force_zero_scaling = true,
    },
    render = {
        direct_scanout = 2,
    },
    cursor = {
        inactive_timeout = 30,
        hide_on_key_press = false,
    },
    dwindle = {
        preserve_split = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
}

---------------
--- DEVICES ---
---------------
hl.device {
    name = 'logitech-g502-hero-gaming-mouse',
    sensitivity = 1,
}

hl.device {
    name = 'trackpad-von-pno',
    sensitivity = 0.3,
    tap_to_click = true,
    disable_while_typing = false,
    natural_scroll = true,
}

hl.device {
    name = 'thomas-haukland-cheapino2-keyboard',
    kb_layout = 'de_mac_only_diaeresis,de',
    kb_variant = '',
    kb_model = '',
    kb_options = '',
    kb_rules = '',
}

------------------
--- ANIMATIONS ---
------------------
hl.curve('overshot', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve('exponential', { type = 'bezier', points = { { 0.55, 0 }, { 1, 0.45 } } })

hl.animation { leaf = 'windowsIn', enabled = true, speed = 2, bezier = 'overshot', style = 'popin 50%' }
hl.animation { leaf = 'windowsOut', enabled = true, speed = 2, bezier = 'exponential', style = 'popin' }
hl.animation { leaf = 'windowsMove', enabled = true, speed = 0.5, bezier = 'default', style = 'slide' }
hl.animation { leaf = 'layersIn', enabled = true, speed = 5, bezier = 'overshot', style = 'slide' }
hl.animation { leaf = 'layersOut', enabled = true, speed = 5, bezier = 'overshot', style = 'slide' }
hl.animation { leaf = 'border', enabled = true, speed = 5, bezier = 'default' }
hl.animation { leaf = 'borderangle', enabled = true, speed = 5, bezier = 'default' }
hl.animation { leaf = 'fade', enabled = true, speed = 2, bezier = 'default' }
hl.animation { leaf = 'workspaces', enabled = true, speed = 2, bezier = 'default' }
hl.animation { leaf = 'specialWorkspace', enabled = true, speed = 2, bezier = 'default', style = 'slidefadevert -50%' }

--------------------
--- KEY MAPPINGS ---
--------------------
local mainMod = 'SUPER'

-- System
-- Note: Python string escaping in lua needs care, wrapping it in a shell script is highly recommended,
-- but this keeps your existing shell inline:
hl.bind(
    mainMod .. ' + SHIFT + A',
    hl.dsp.exec_cmd [[wl-paste | python -c 'import sys; x = sys.stdin.read(); [sys.stdout.write(x.replace("**", "").replace("$$", "\(", 1).replace("$$", "\)", 1).replace("$", "\(", 1).replace("$", "\)", 1)) for _ in iter(int, 1) if "$" in x]' | wl-copy]]
)
hl.bind(mainMod .. ' + ESCAPE', hl.dsp.exec_cmd(logout))
hl.bind(mainMod .. ' + SHIFT + M', hl.dsp.exit(), { locked = true })
hl.bind(mainMod .. ' + SHIFT + X', hl.dsp.exec_cmd('hyprctl switchxkblayout ' .. keyboard .. ' next'))

-- Window Control
hl.bind(mainMod .. ' + F', hl.dsp.window.fullscreen())
hl.bind(mainMod .. ' + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(mainMod .. ' + T', hl.dsp.layout 'togglesplit')
hl.bind(mainMod .. ' + X', hl.dsp.window.pin())
hl.bind(mainMod .. ' + SHIFT + V', hl.dsp.window.pseudo())
hl.bind(mainMod .. ' + C', hl.dsp.window.close())
hl.bind(mainMod .. ' + SHIFT + C', hl.dsp.window.kill())

-- Launchers
hl.bind(mainMod .. ' + A', hl.dsp.exec_cmd(apps))
hl.bind(mainMod .. ' + Y', hl.dsp.exec_cmd(files))
hl.bind(mainMod .. ' + SHIFT + Y', hl.dsp.exec_cmd(disks))
hl.bind(mainMod .. ' + SHIFT + W', hl.dsp.exec_cmd(togglebar))
hl.bind(mainMod .. ' + Z', hl.dsp.exec_cmd(pdfsearchname))
hl.bind(mainMod .. ' + SHIFT + Z', hl.dsp.exec_cmd(pdfsearchcontent))

-- Toggles
hl.bind(mainMod .. ' + B', hl.dsp.exec_cmd(toggleblueman))
hl.bind(mainMod .. ' + SHIFT + B', hl.dsp.exec_cmd(togglebluetooth))

-- Terminal & Browser
hl.bind(mainMod .. ' + Q', hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. ' + SHIFT + Q', hl.dsp.exec_cmd('[float; size 60% 30%] ' .. terminal))
hl.bind(mainMod .. ' + E', function()
    local handle = io.popen('pidof ' .. browser)
    if handle == nil then
        return
    end

    local pid = handle:read '*a'
    handle:close()

    if pid:match '%S' then
        hl.dispatch(hl.dsp.focus { window = 'class:' .. browser })
    else
        hl.dispatch(hl.dsp.exec_cmd(browser))
    end
end)
hl.bind(mainMod .. ' + SHIFT + E', hl.dsp.exec_cmd(browser .. ' --private-window'))

-- Utils
hl.bind(mainMod .. ' + SHIFT + D', hl.dsp.exec_cmd [[xdg-open "$(find ~/Downloads -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -d' ' -f2-)"]])
hl.bind(mainMod .. ' + S', hl.dsp.exec_cmd(regionscreenshot))
hl.bind(mainMod .. ' + SHIFT + S', hl.dsp.exec_cmd(windowscreenshot))
hl.bind(mainMod .. ' + P', hl.dsp.exec_cmd(colorpicker))
hl.bind(mainMod .. ' + SHIFT + P', hl.dsp.exec_cmd(colorselector))

hl.bind(mainMod .. ' + U', hl.dsp.exec_cmd 'obsidian "obsidian://open?vault=university"')
hl.bind(mainMod .. ' + D', hl.dsp.exec_cmd 'obsidian "obsidian://open?vault=notes"')

hl.bind(mainMod .. ' + N', hl.dsp.exec_cmd(notifyDismiss))
hl.bind(mainMod .. ' + SHIFT + N', hl.dsp.exec_cmd(notifyRestore))

-- Focus and Swap
hl.bind(mainMod .. ' + H', hl.dsp.focus { direction = 'left' })
hl.bind(mainMod .. ' + J', hl.dsp.focus { direction = 'down' })
hl.bind(mainMod .. ' + K', hl.dsp.focus { direction = 'up' })
hl.bind(mainMod .. ' + L', hl.dsp.focus { direction = 'right' })

hl.bind(mainMod .. ' + SHIFT + H', hl.dsp.window.swap { direction = 'left' })
hl.bind(mainMod .. ' + SHIFT + J', hl.dsp.window.swap { direction = 'down' })
hl.bind(mainMod .. ' + SHIFT + K', hl.dsp.window.swap { direction = 'up' })
hl.bind(mainMod .. ' + SHIFT + L', hl.dsp.window.swap { direction = 'right' })

-- Switch Workspaces
local function focus(i)
    return function()
        local activeSpecial = hl.get_active_special_workspace()
        if activeSpecial ~= nil then
            hl.dispatch(hl.dsp.workspace.toggle_special(activeSpecial.name:sub(9)))
        end
        hl.dispatch(hl.dsp.focus { workspace = i })
    end
end
local function move(i)
    return function()
        local activeSpecial = hl.get_active_special_workspace()
        if activeSpecial ~= nil then
            hl.dispatch(hl.dsp.workspace.toggle_special(activeSpecial.name:sub(9)))
        end
        hl.dispatch(hl.dsp.window.move { workspace = i })
    end
end

hl.bind(mainMod .. ' + 0', focus(10))
hl.bind(mainMod .. ' + SHIFT + 0', move(10))
for i = 1, 9 do
    hl.bind(mainMod .. ' + ' .. i, focus(i))
    hl.bind(mainMod .. ' + SHIFT + ' .. i, move(i))
end

hl.bind(mainMod .. ' + TAB', focus 'r+1', { repeating = true })
hl.bind(mainMod .. ' + SHIFT + TAB', focus 'r-1', { repeating = true })

-- Mouse binds
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Media Keys
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd(media .. ' volume up'), { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd(media .. ' volume down'), { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd(media .. ' volume toggle'), { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd(media .. ' display-brightness up'), { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd(media .. ' display-brightness down'), { locked = true, repeating = true })
hl.bind('XF86KbdBrightnessUp', hl.dsp.exec_cmd(media .. ' keyboard-brightness up'), { locked = true, repeating = true })
hl.bind('XF86KbdBrightnessDown', hl.dsp.exec_cmd(media .. ' keyboard-brightness down'), { locked = true, repeating = true })

hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'playerctl previous', { locked = true })

-- Special Workspaces
hl.bind(mainMod .. ' + G', hl.dsp.workspace.toggle_special 'magic')
hl.bind(mainMod .. ' + SHIFT + G', hl.dsp.window.move { workspace = 'special:magic' })
hl.bind(mainMod .. ' + M', hl.dsp.workspace.toggle_special 'mails')

-- Lid Switch
hl.bind('switch:off:[Lid Switch]', hl.dsp.dpms { action = 'enable' }, { locked = true })
hl.bind('switch:on:[Lid Switch]', hl.dsp.dpms { action = 'disable' }, { locked = true })
