local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be separated by commas

local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
    "powerarrow-blue", -- 11
}

local chosen_theme = themes[4]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "alacritty"
local vi_focus     = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274
local editor       = "emacsclient -c -n -a emacs"
local gui_editor   = "emacsclient -c -n -a emacs"
local browser      = os.getenv("BROWSER") or "firefox"
local scrlocker    = "slock"

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = my_table.join(
  awful.key({ modkey, },
        "s",
        hotkeys_popup.show_help,
        {
          description="show help",
          group="awesome"
        }),

    awful.key({ modkey, },
        "Left",
        awful.tag.viewprev,
        {
          description = "view previous",
          group = "tag"
        }),

    awful.key({ modkey, },
        "Right",
        awful.tag.viewnext,
        {
          description = "view next",
          group = "tag"
        }),

    awful.key({ modkey, },
        "Escape",
        awful.tag.history.restore,
        {
          description = "go back",
          group = "tag"
        }),

    awful.key({ modkey, },
        "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {
          description = "focus next by index",
          group = "client"
        }),

    awful.key({ modkey, },
        "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {
          description = "focus previous by index",
          group = "client"
        }),

    -- Layout manipulation

    awful.key({ modkey, "Shift" },
        "j",
        function ()
          awful.client.swap.byidx(  1)
        end,
        {
          description = "swap with next client by index",
          group = "client"
        }),

    awful.key({ modkey, "Shift" },
        "k",
        function ()
          awful.client.swap.byidx( -1)
        end,
        {
          description = "swap with previous client by index",
          group = "client"
        }),

    awful.key({ modkey, "Control" },
        "j",
        function ()
          awful.screen.focus_relative( 1)
        end,
        {
          description = "focus the next screen",
          group = "screen"
        }),

    awful.key({ modkey, "Control" },
        "k",
        function ()
          awful.screen.focus_relative(-1)
        end,
        {
          description = "focus the previous screen",
          group = "screen"
        }),

    awful.key({ modkey, },
        "u",
        awful.client.urgent.jumpto,
        {
          description = "jump to urgent client",
          group = "client"
        }),

    awful.key({ modkey, },
        "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {
          description = "go back",
          group = "client"
        }),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- Standard program

    awful.key({ modkey, },
        "Return",
        function ()
          awful.spawn(terminal)
        end,
        {
          description = "open a terminal",
          group = "launcher"
        }),

     awful.key({ modkey, "Shift" },
        "Return",
        function ()
          awful.spawn(string.format("dmenu_run -h 20 -fn 'Sauce Code Pro Nerd Font:size=10' -nb '%s' -nf '%s' -sb '%s' -sf '%s'", beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {
            description = "Launches rofi",
            group = "launcher"
        }),

    awful.key({ modkey, "Shift" },
        "s",
        function () awful.util.spawn("spotify") end,
        {
            description = "Launches spotify",
            group = "gui applications"
        }),

    awful.key({ modkey, },
        "w",
        function () awful.util.spawn(browser) end,
        {
            description = "Launches " .. browser,
            group = "gui applications"
        }),

    awful.key({ modkey, },
        "e",
        function () awful.util.spawn(editor) end,
        {
            description = "Launches " .. editor,
            group = "gui applications"
        }),

    awful.key({ modkey, "Control" },
        "r",
        awesome.restart,
        {
          description = "reload awesome",
          group = "awesome"
        }),

    awful.key({ modkey, "Shift" },
        "q",
        awesome.quit,
        {
          description = "quit awesome",
          group = "awesome"
        }),

    awful.key({ modkey, },
        "l",
        function ()
          awful.tag.incmwfact( 0.05)
        end,
        {
          description = "increase master width factor",
          group = "layout"
        }),

    awful.key({ modkey, },
        "h",
        function ()
          awful.tag.incmwfact(-0.05)
        end,
        {
          description = "decrease master width factor",
          group = "layout"
        }),

    awful.key({ modkey, "Shift" },
        "h",
        function ()
          awful.tag.incnmaster( 1, nil, true)
        end,
        {
          description = "increase the number of master clients",
          group = "layout"
        }),

    awful.key({ modkey, "Shift" },
        "l",
        function ()
          awful.tag.incnmaster(-1, nil, true)
        end,
        {
          description = "decrease the number of master clients",
          group = "layout"
        }),

    awful.key({ modkey, "Control" },
        "h",
        function ()
          awful.tag.incncol( 1, nil, true)
        end,
        {
          description = "increase the number of columns",
          group = "layout"
        }),

    awful.key({ modkey, "Control" },
        "l",
        function ()
          awful.tag.incncol(-1, nil, true)
        end,
        {
          description = "decrease the number of columns",
          group = "layout"
        }),

    awful.key({ modkey, },
        "space",
        function ()
          awful.layout.inc( 1)
        end,
        {
          description = "select next",
          group = "layout"
        }),

    awful.key({ modkey, "Shift" },
        "space",
        function ()
          awful.layout.inc(-1)
        end,
        {
          description = "select previous",
          group = "layout"
        }),

    awful.key({ modkey, "Control" },
        "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                  "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,
        {
          description = "restore minimized",
          group = "client"
        }),


    -- Widgets popups
    awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
              {description = "show calendar", group = "widgets"}),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              {description = "show filesystem", group = "widgets"}),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              {description = "show weather", group = "widgets"}),

    -- User programs
    awful.key({ modkey }, "q", function () awful.spawn(browser) end,
              {description = "run browser", group = "launcher"}),
    awful.key({ modkey }, "a", function () awful.spawn(gui_editor) end,
              {description = "run gui editor", group = "launcher"}),

    -- Multimedia keys
    awful.key({ },
        "XF86AudioLowerVolume",
        function ()
        awful.util.spawn("pulsemixer --change-volume -2")
        end,
        {
          description = "lower volume",
          group = "multimedia keys"
        }),
  
    awful.key({ },
        "XF86AudioRaiseVolume",
        function ()
        awful.util.spawn("pulsemixer --change-volume +2 && pulsemixer --max-volume 100")
        end,
        {
          description = "raise volume",
          group = "multimedia keys"
        }),

    awful.key({ },
        "XF86AudioMute",
        function ()
        awful.util.spawn("pulsemixer --toggle-mute")
        end,
        {
          description = "toggle mute",
          group = "multimedia keys"
        }),

    awful.key({ },
        "XF86AudioPlay",
        function ()
        awful.util.spawn("playerctl -p spotify play-pause")
        end,
        {
          description = "play/pause",
          group = "multimedia keys"
        }),

    awful.key({ },
        "XF86AudioNext",
        function ()
        awful.util.spawn("playerctl -p spotify next")
        end,
        {
          description = "next song",
          group = "multimedia keys"
        }),

    awful.key({ },
        "XF86AudioPrev",
        function ()
        awful.util.spawn("playerctl -p spotify previous")
        end,
        {
          description = "previous song",
          group = "multimedia keys"
        }),

    awful.key({ },
        "XF86AudioStop",
        function ()
        awful.util.spawn("playerctl -p spotify stop")
        end,
        {
          description = "stop song",
          group = "multimedia keys"
        }),

    -- Dmenu scripts
    awful.key({ modkey, },
        "F6",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenu-power.sh")
        end,
        {
          description = "power script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F7",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenu-ssh.sh")
        end,
        {
          description = "ssh script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F8",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenu-sysmon.sh")
        end,
        {
          description = "system monitor script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F9",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenumount.sh")
        end,
        {
          description = "mount script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F10",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenuumount.sh")
        end,
        {
          description = "unmount script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F11",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenu-scrot.sh")
        end,
        {
          description = "scrot script",
          group = "dmenu scripts"
        }),

  awful.key({ modkey, },
        "F12",
        function ()
        awful.util.spawn("./.config/dmenu/scripts/dmenu-edit-configs.sh")
        end,
        {
          description = "edit configurations script",
          group = "dmenu scripts"
        })
) 

clientkeys = my_table.join(
    awful.key({ modkey, },
        "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {
          description = "toggle fullscreen",
          group = "client"
        }),
    
    awful.key({ modkey, "Shift" },
        "c",
        function (c)
          c:kill()
        end,
        {
          description = "close",
          group = "client"
        }),
    
    awful.key({ modkey, "Control" },
        "space",
        awful.client.floating.toggle,
        {
          description = "toggle floating",
          group = "client"
        }),
    
    awful.key({ modkey, "Control" },
        "Return",
        function (c)
          c:swap(awful.client.getmaster())
        end,
        {
          description = "move to master",
          group = "client"
        }),
    
    awful.key({ modkey, },
        "o",
        function (c)
          c:move_to_screen()
        end,
        {
          description = "move to screen",
          group = "client"
        }),
    
    awful.key({ modkey, },
        "t",
        function (c)
          c.ontop = not c.ontop
        end,
        {
          description = "toggle keep on top",
          group = "client"
        }),
    
    awful.key({ modkey, },
        "n",
        function (c)
            c.minimized = true
        end,
        {
          description = "minimize",
          group = "client"
        }),
    
    awful.key({ modkey, },
        "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {
          description = "(un)maximize",
          group = "client"
        }),
    
    awful.key({ modkey, "Control" },
        "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {
          description = "(un)maximize vertically",
          group = "client"
        }),
    
    awful.key({ modkey, "Shift" },
        "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {
          description = "(un)maximize horizontally",
          group = "client"
        })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey },
            "#" .. i + 9,
             function ()
                   local screen = awful.screen.focused()
                   local tag = screen.tags[i]
                   if tag then
                      tag:view_only()
                   end
             end,
             {
               description = "view tag #"..i,
               group = "tag"
             }),
        
        awful.key({ modkey, "Control" }, "#" .. i + 9,
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               awful.tag.viewtoggle(tag)
            end
        end,
        {
          description = "toggle tag #" .. i,
          group = "tag"
        }),
        
        awful.key({ modkey, "Shift" },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
               end
            end,
            {
              description = "move focused client to tag #"..i,
              group = "tag"
            }),
        
        awful.key({ modkey, "Control", "Shift" },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
              description = "toggle focused client on tag #" .. i,
              group = "tag"
            })
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Set Firefox to always map on the first tag on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = awful.util.tagnames[1] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
}

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function() c:kill() end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(16)}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("xset r rate 300 50 &")
awful.spawn.with_shell("xset s off -dpms &")
awful.spawn.with_shell("xrdb ~/.Xresources &")
awful.spawn.with_shell("~/.config/fixmonitors.sh &")
awful.spawn.with_shell("xmodmap ~/.Xmodmap &")
awful.spawn.with_shell("xcompmgr &")
awful.spawn.with_shell("wmname LG3D &")
awful.spawn.with_shell("/usr/bin/emacs --daemon &")
awful.spawn.with_shell("feh --bg-scale ~/.config/wallpaper &")
