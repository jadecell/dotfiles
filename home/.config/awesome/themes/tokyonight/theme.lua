local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = xresources.apply_dpi
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/"

-- BASICS
local theme = {}

theme.background    = "#1f2335"
theme.foreground    = "#c0caf5"
theme.black         = "#414868"
theme.red           = "#f7768e"
theme.green         = "#9ece6a"
theme.yellow        = "#e0af68"
theme.blue          = "#7aa2f7"
theme.magenta       = "#bb9af7"
theme.cyan          = "#7dcfff"
theme.white         = "#c0caf5"
theme.darkblue      = "#0db9d7"
theme.orange        = "#ff9e64"
theme.pink          = "#ff007c"
theme.teal          = "#1abc9c"

theme.font          = "Iosevka Nerd Font 11"

theme.bg_focus      = theme.background
theme.bg_normal     = "#24283b"
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.blue
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.foreground
theme.fg_focus      = theme.pink
theme.fg_urgent     = theme.red
theme.fg_minimize   = theme.foreground

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(2)
theme.border_normal = "#808080"
theme.border_focus  = theme.teal
theme.border_marked = theme.green

theme.notification_font = theme.font
theme.notification_bg = theme.background
theme.notification_fg = theme.foreground
theme.notification_border_color = theme.magenta
theme.notification_font          = "Iosevka Nerd Font 14"
theme.notification_border_width                 = 0
theme.notification_shape = function(cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, 6)
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
