local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = xresources.apply_dpi
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/" 

-- BASICS
local theme = {}

theme.background    = "#1e1e1e"
theme.foreground    = "#d4d4d4"
theme.black         = "#3b4252"
theme.red           = "#f44747"
theme.green         = "#4ec9b0"
theme.yellow        = "#d7ba7d"
theme.blue          = "#569cd6"
theme.magenta       = "#c586c0"
theme.cyan          = "#9cdcfe"
theme.white         = "#d4d4d4"

theme.font          = "Iosevka Nerd Font 11"

theme.bg_focus      = theme.background
theme.bg_normal     = "#212121"
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.blue
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.foreground
theme.fg_focus      = theme.blue
theme.fg_urgent     = theme.red
theme.fg_minimize   = theme.foreground

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(2)
theme.border_normal = "#808080"
theme.border_focus  = theme.blue
theme.border_marked = theme.green

theme.notification_font = theme.font
theme.notification_bg = theme.background
theme.notification_fg = theme.foreground
theme.notification_font          = "JetBrains Mono Nerd Font 12"
theme.notification_shape = function(cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, 10)
        end

-- from default for now...
theme.menu_submenu_icon     = "/usr/share/awesome/themes/default/submenu.png"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- MISC
--theme.wallpaper             = themes_path .. "sky/sky-background.png"
theme.taglist_squares       = "true"
theme.titlebar_close_button = "true"
theme.menu_height = dpi(24)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.titlebar_close_button_focus               = themes_path .. "codedark/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = themes_path .. "codedark/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active        = themes_path .. "codedark/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "codedark/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "codedark/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = themes_path .. "codedark/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active       = themes_path .. "codedark/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "codedark/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "codedark/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = themes_path .. "codedark/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active     = themes_path .. "codedark/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "codedark/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "codedark/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = themes_path .. "codedark/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_minimize_button_focus    = themes_path .. "codedark/icons/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_normal   = themes_path .. "codedark/icons/titlebar/minimize_normal.png"

theme.titlebar_maximized_button_focus_active    = themes_path .. "codedark/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "codedark/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "codedark/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "codedark/icons/titlebar/maximized_normal_inactive.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
