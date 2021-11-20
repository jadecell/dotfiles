-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful") 
-- Notification library 
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
local terminal = os.getenv("TERMINAL") or "xterm"
local browser = os.getenv("BROWSER") or "firefox"
local editor = os.getenv("EDITOR") or "vi"
local editor_cmd = terminal .. " -e " .. editor
local homedir = os.getenv("HOME")
local scriptsdir = homedir .. "/.local/bin"
local awesomedir = homedir .. "/.config/awesome"
local dmenuscriptsdir = homedir .. "/.config/dmenu/scripts"
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awesomedir .. "/themes/codedark/theme.lua")
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    })
end)
-- }}}

-- {{{ Wibar

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
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
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })
    local sbSep = wibox.widget.textbox(" | ")
    local sbKernel = awful.widget.watch(scriptsdir .. "/statusbar/sb-kernel dwm", 7200)
    local sbCpuperc = awful.widget.watch(scriptsdir .. "/statusbar/sb-cpuperc dwm", 5)
    local sbCputemp = awful.widget.watch(scriptsdir .. "/statusbar/sb-cputemp", 5)
    local sbMemory = awful.widget.watch(scriptsdir .. "/statusbar/sb-memory dwm", 5)
    local sbUptime = awful.widget.watch(scriptsdir .. "/statusbar/sb-upt dwm", 60)
    local sbClock = awful.widget.watch(scriptsdir .. "/statusbar/sb-clock dwm", 1)
    local sbNetworking = awful.widget.watch(scriptsdir .. "/statusbar/sb-networking", 1)
    local sbPackages = awful.widget.watch(scriptsdir .. "/statusbar/sb-packcount dwm", 1)
    local sbMail = awful.widget.watch(scriptsdir .. "/statusbar/sb-mail", 5)

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            sbMail,
            sbSep,
            sbCpuperc,
            sbSep,
            sbMemory,
            sbSep,
            sbPackages,
            sbSep,
            sbCputemp,
            sbSep,
            sbUptime,
            sbSep,
            sbClock,
            sbSep,
            sbNetworking,
            sbSep,
            wibox.widget.systray(),
            wibox.widget.textbox(" ")
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({

    awful.key({ modkey, }, "w", 
              function () 
                awful.spawn(browser)
              end,
              {
                description = "open the " .. browser .. " browser", 
                group = "application"
              }),

    awful.key({ modkey, "Control", "Shift"}, "w", 
              function () 
                awful.spawn("wallchoose")
              end,
              {
                description = "choose the wallpaper",
                group = "application"
              }),

    awful.key({ modkey, }, "n", 
              function () 
                awful.spawn(terminal .. " -e newsboat")
              end,
              {
                description = "open the newsboat rss reader", 
                group = "application"
              }),

    awful.key({ modkey, }, "m", 
              function () 
                awful.spawn(terminal .. " -e ncmpcpp")
              end,
              {
                description = "open the ncmpcpp mpd client", 
                group = "application"
              }),

    awful.key({ modkey, }, "t", 
              function () 
                awful.spawn(terminal .. " -e stig")
              end,
              {
                description = "open the stig torrent client", 
                group = "application"
              }),

    awful.key({ modkey, }, "v", 
              function () 
                awful.spawn("togglevpn")
              end,
              {
                description = "toggle vpn connection", 
                group = "application"
              }),

    awful.key({ modkey, "Shift" }, "m", 
              function () 
                awful.spawn("thunderbird")
              end,
              {
                description = "open thunderbird", 
                group = "application"
              }),

    awful.key({ modkey, }, "u", 
              function () 
                awful.spawn(terminal .. " -e update-system")
              end,
              {
                description = "open the update system script", 
                group = "application"
              }),


    awful.key({}, "XF86AudioPlay", 
              function () 
                awful.spawn(scriptsdir .. "/music-control toggle")
              end,
              {
                description = "toggle mpd", 
                group = "music control"
              }),

    awful.key({}, "XF86AudioPrev", 
              function () 
                awful.spawn(scriptsdir .. "/music-control prev")
              end,
              {
                description = "previous song in mpd", 
                group = "music control"
              }),

    awful.key({}, "XF86AudioNext", 
              function () 
                awful.spawn(scriptsdir .. "/music-control next")
              end,
              {
                description = "next song in mpd", 
                group = "music control"
              }),

    awful.key({}, "XF86AudioStop", 
              function () 
                awful.spawn(scriptsdir .. "/music-control stop")
              end,
              {
                description = "stop the song currently playing in mpd", 
                group = "music control"
              }),

    awful.key({ modkey, }, "/",      
              hotkeys_popup.show_help,
              {
                description="show help", 
                group="awesome"
              }),

    awful.key({ modkey, "Shift" }, "r", 
              awesome.restart,
              {
                description = "reload awesome", 
                group = "awesome"
              }),

    awful.key({ modkey, "Shift" }, "q", 
              awesome.quit,
              {
                description = "quit awesome", 
                group = "awesome"
              }),

    awful.key({ modkey, }, "Return", 
              function () 
                awful.spawn(terminal) 
              end,
              {
                description = "open a terminal", 
                group = "launcher"
              }),

    awful.key({ modkey, "Shift" }, "Return", 
              function () 
                awful.spawn("/home/jackson/.config/rofi/launchers/colorful/launcher.sh") 
              end,
              {
                description = "open a dmenu instance", 
                group = "launcher"
              }),

    -- awful.key({ modkey, "Shift" }, "Return", 
    --           function () 
    --             awful.spawn("dmenu_run -i") 
    --           end,
    --           {
    --             description = "open a dmenu instance", 
    --             group = "launcher"
    --           }),

    -- Dmenu scripts
    awful.key({ modkey, "Control" }, "p", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-power.sh") 
              end,
              {
                description = "power menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control", "Shift" }, "b", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-bookmarks.sh") 
              end,
              {
                description = "bookmarks menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "b", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-browse.sh") 
              end,
              {
                description = "browse menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control", "Shift" }, "c", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-calc.sh") 
              end,
              {
                description = "calc menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "c", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-edit-configs.sh") 
              end,
              {
                description = "edit configs menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "m", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-mount.sh") 
              end,
              {
                description = "mount menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control", "Shift" }, "m", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-umount.sh") 
              end,
              {
                description = "umount menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "s", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-ssh.sh") 
              end,
              {
                description = "ssh menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control", "Shift" }, "s", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-scrot.sh") 
              end,
              {
                description = "scrot menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "y", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-sysmon.sh") 
              end,
              {
                description = "system monitor menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "t", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-timer.sh") 
              end,
              {
                description = "timer menu", 
                group = "dmenu scripts"
              }),

    awful.key({ modkey, "Control" }, "u", 
              function () 
                awful.spawn(dmenuscriptsdir .. "/dmenu-unicode.sh") 
              end,
              {
                description = "unicode menu", 
                group = "dmenu scripts"
              }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({

    awful.key({ modkey, }, "Left",   
              awful.tag.viewprev,
              {
                description = "view previous", 
                group = "tag"
              }),

    awful.key({ modkey, }, "Right",  
              awful.tag.viewnext,
              {
                description = "view next", 
                group = "tag"
              }),

    awful.key({ modkey, }, "Escape", 
              awful.tag.history.restore,
              {
                description = "go back",
                group = "tag"
              }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({

    awful.key({ modkey,  }, "j",
              function ()
                  awful.client.focus.byidx( 1)
              end,
              {
                description = "focus next by index", 
                group = "client"
              }),

    awful.key({ modkey, }, "k",
              function ()
                  awful.client.focus.byidx(-1)
              end,
              {
                description = "focus previous by index", 
                group = "client"
              }),

    awful.key({ modkey, }, ".", 
              function () 
                awful.screen.focus_relative(1) 
              end,
              {
                description = "focus the next screen", 
                group = "screen"
              }),

    awful.key({ modkey, }, ",", 
              function () 
                awful.screen.focus_relative(-1) 
              end,
              {
                description = "focus the previous screen", 
                group = "screen"
              }),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {
                description = "restore minimized", 
                group = "client"
              }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({

    awful.key({ modkey, "Shift" }, "j", 
              function () 
                awful.client.swap.byidx(1)
              end,
              {
                description = "swap with next client by index", 
                group = "client"
              }),

    awful.key({ modkey, "Shift" }, "k", 
              function () 
                awful.client.swap.byidx( -1)
              end,
              {
                description = "swap with previous client by index", 
                group = "client"
              }),

    awful.key({ modkey, "Shift" }, "u", 
              awful.client.urgent.jumpto,
              {
                description = "jump to urgent client", 
                group = "client"
              }),

    awful.key({ modkey, }, "l",     
              function () 
                awful.tag.incmwfact( 0.05)  
              end,
              {
                description = "increase master width factor", 
                group = "layout"
              }),

    awful.key({ modkey,  }, "h",     
              function () 
                awful.tag.incmwfact(-0.05)
              end,
              {
                description = "decrease master width factor", 
                group = "layout"
              }),

    awful.key({ modkey, "Shift" }, "h",     
              function () 
                awful.tag.incnmaster(1, nil, true) 
              end,
              {
                description = "increase the number of master clients", 
                group = "layout"
              }),

    awful.key({ modkey, "Shift" }, "l",     
              function () 
                awful.tag.incnmaster(-1, nil, true)
              end,
              {
                description = "decrease the number of master clients", 
                group = "layout"
              }),

--     awful.key({ modkey, "Control" }, "h",
--               function () 
--                 awful.tag.incncol(1, nil, true) 
--               end,
--               {
--                 description = "increase the number of columns", 
--                 group = "layout"
--               }),

--     awful.key({ modkey, "Control" }, "l",
--               function () 
--                 awful.tag.incncol(-1, nil, true)
--               end,
--               {
--                 description = "decrease the number of columns", 
--                 group = "layout"
--               }),

--     awful.key({ modkey, }, "space", 
--               function () 
--                 awful.layout.inc(1)
--               end,
--               {
--                 description = "select next", 
--                 group = "layout"
--               }),

--     awful.key({ modkey, "Shift" }, "space", 
--               function () 
--                 awful.layout.inc(-1)
--               end,
--               {
--                 description = "select previous", 
--                 group = "layout"
--               }),
})


awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

        awful.key({ modkey, }, "space",
                  function (c)
                      c.fullscreen = not c.fullscreen
                      c:raise()
                  end,
                  {
                    description = "toggle fullscreen", 
                    group = "client"
                  }),

        awful.key({ modkey, "Shift" }, "c",      
                  function (c) 
                    c:kill()
                  end,
                  {
                    description = "close", 
                    group = "client"
                  }),

        awful.key({ modkey, "Control" }, "space",  
                  awful.client.floating.toggle,
                  {
                    description = "toggle floating", 
                    group = "client"
                  }),

        awful.key({ modkey, "Control" }, "Return", 
                  function (c)
                    c:swap(awful.client.getmaster()) 
                  end,
                  {
                    description = "move to master", 
                    group = "client"
                  }),
                  
        awful.key({ modkey, }, "o", 
                  function (c) 
                    c:move_to_screen()
                  end,
                  {
                    description = "move to screen", 
                    group = "client"
                  }),

        awful.key({ modkey, }, "t", 
                  function (c) 
                    c.ontop = not c.ontop
                  end,
                  {
                    description = "toggle keep on top", 
                    group = "client"
                  }),

        awful.key({ modkey, "Shift" }, "n",
                  function (c)
                      -- The client currently has the input focus, so it cannot be
                      -- minimized, since minimized clients can't have the focus.
                      c.minimized = true
                  end ,
                  {
                    description = "minimize", 
                    group = "client"
                  }),

--         awful.key({ modkey, "Shift" }, "m",
--                   function (c)
--                       c.maximized = not c.maximized
--                       c:raise()
--                   end,
--                   {
--                     description = "(un)maximize", 
--                     group = "client"
--                   }),

--         awful.key({ modkey, "Control" }, "m",
--                   function (c)
--                       c.maximized_vertical = not c.maximized_vertical
--                       c:raise()
--                   end ,
--                   {
--                     description = "(un)maximize vertically", 
--                     group = "client"
--                   }),

--         awful.key({ modkey, "Shift"   }, "m",
--                   function (c)
--                       c.maximized_horizontal = not c.maximized_horizontal
--                       c:raise()
--                   end ,
--                   {
--                     description = "(un)maximize horizontally", 
--                     group = "client"
--                   }),
    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "dialog" } },
        properties = { titlebars_enabled = true      }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)

-- }}}

-- {{{ Titlebars

-- Titlebars only on floating windows
client.connect_signal("property::floating", function(c)
    if c.floating then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c).widget = {
        { -- Left
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.iconwidget(c),
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
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

    -- Add rounded corners on floating windows
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 5)
    end
end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
