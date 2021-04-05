import XMonad
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
 
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

import Data.Char (isSpace)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:Sauce Code Pro Nerd Font:bold:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask       

myTerminal :: String
myTerminal = "alacritty "  

myEditor :: String
myEditor = "emacsclient -c -n -a 'emacs'"

myGUIBrowser :: String
myGUIBrowser = "librewolf" 

myBorderWidth :: Dimension
myBorderWidth = 2         

myNormColor :: String
myNormColor   = "#1c1f24" 

myFocusColor :: String
myFocusColor  = "#ff6c6b" 

altMask :: KeyMask
altMask = mod1Mask

myStartupHook :: X ()
myStartupHook = do
          spawnOnce "feh --bg-scale /home/jackson/.config/wallpaper &"
          spawnOnce "trayer --edge top --align right --widthtype request --monitor 1 --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x282c34 --height 24 &"
          spawnOnce "xset s off -dpms &"
          spawnOnce "xset r rate 300 50 &"
          spawnOnce "xmodmap /home/jackson/.Xmodmap &"
          spawnOnce "/usr/bin/emacs --daemon &"
          spawnOnce "xrdb /home/jackson/.Xresources &"
          spawnOnce "/bin/sh /home/jackson/.config/fixmonitors.sh &"
          spawnOnce "killall dunst ; dunst &"
          setWMName "LG3D"

jacksonXPConfig :: XPConfig
jacksonXPConfig = def
      { font                = myFont
      , bgColor             = "#0f0f0f"
      , fgColor             = "#50fa7b"
      , bgHLight            = "#f8f8f8"
      , fgHLight            = "#0f0f0f"
      , borderColor         = "#98971a"
      , promptBorderWidth   = 0
      , promptKeymap        = jacksonXPKeymap
      , position            = Top
--    , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 24
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

jacksonXPConfig' :: XPConfig
jacksonXPConfig' = jacksonXPConfig
      { autoComplete        = Nothing
      }

archWiki :: S.SearchEngine

archWiki = S.searchEngine "archWiki" "https://wiki.archlinux.org/index.php?search="

searchList :: [(String, S.SearchEngine)]
searchList = [ ("d", S.duckduckgo)
             , ("a", archWiki)
             , ("h", S.hoogle)
             , ("t", S.thesaurus)
             , ("v", S.vocabulary)
             ]

promptList :: [(String, XPConfig -> X ())]
promptList = [ ("m", manPrompt)          -- manpages prompt
             , ("s", sshPrompt)          -- ssh prompt
             , ("x", xmonadPrompt)       -- xmonad prompt
             ]

promptList' :: [(String, XPConfig -> String -> X (), String)]
promptList' = [ ("c", calcPrompt, "qalc")         -- requires qalculate-gtk
              ]

calcPrompt c ans =
    inputPrompt c (trim ans) ?+ \input ->
        liftIO(runProcessWithInput "qalc" [input] "") >>= calcPrompt c
    where
        trim  = f . f
            where f = reverse . dropWhile isSpace

jacksonXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
jacksonXPKeymap = M.fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_y, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) altMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "tall"]
           $ limitWindows 12
           $ mySpacing 6
           $ ResizableTall 1 (3/100) (1/2) []
floats   = renamed [Replace "floats"]
           $ limitWindows 20 simplestFloat

myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Sans:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#000000"
    , swn_color             = "#FFFFFF"
    }

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     tall
                                 ||| floats

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
               $ ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ "> " ++ ws ++ " </action>" |
                      (i,ws) <- zip [1..9] l,
                      let n = i ]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out
     -- the full name of my workspaces.
     [ (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ]

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myKeys :: [(String, X ())]
myKeys =

        [ ("M-C-r", spawn "xmonad --recompile")      
        , ("M-S-r", spawn "xmonad --restart")       
        , ("M-S-q", spawn "~/.config/dmenu/scripts/dmenu-prompt.sh 'Quit XMonad?' 'killall xinit'")

        , ("M-<Return>", spawn myTerminal)
        , ("M-w", spawn myGUIBrowser)
        , ("M-S-s", spawn "spotify")
        , ("M-u", spawn (myTerminal ++ "-e paru -Syu"))
        , ("M-m", spawn (myTerminal ++ "-e neomutt"))
        , ("M-r", spawn "st -e ranger")
        , ("M-S-w", spawn "st -e ranger ~/.local/repos/wallpapers")

        , ("M-S-<Return>", shellPrompt jacksonXPConfig)

        , ("M-S-c", kill1)

        , ("M-f", sendMessage (T.Toggle "floats"))       
        , ("M-<Delete>", withFocused $ windows . W.sink) 
        , ("M-S-<Delete>", sinkAll)

        , ("M-j", windows W.focusDown)       
        , ("M-k", windows W.focusUp)        
        , ("M-S-j", windows W.swapDown)    
        , ("M-S-k", windows W.swapUp)     
        , ("M-<Backspace>", promote)     
        , ("M1-S-<Tab>", rotSlavesDown) 
        , ("M1-C-<Tab>", rotAllDown)

        , ("M-<Tab>", sendMessage NextLayout)  
        , ("M-C-M1-<Up>", sendMessage Arrange)
        , ("M-C-M1-<Down>", sendMessage DeArrange)
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
        , ("M-S-<Space>", sendMessage ToggleStruts)     
        , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS) 
        , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))
        , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))
        , ("M-S-<KP_Multiply>", increaseLimit)          
        , ("M-S-<KP_Divide>", decreaseLimit)           
        , ("M-h", sendMessage Shrink)     
        , ("M-l", sendMessage Expand)

        , ("M-.", nextScreen)  -- Switch focus to next monitor
        , ("M-,", prevScreen)  -- Switch focus to prev monitor

        , ("M-C-p", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-power.sh")
        , ("M-C-t", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-timer.sh")
        , ("M-C-s", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-ssh.sh")
        , ("M-C-y", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-sysmon.sh")
        , ("M-C-m", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-mount.sh")
        , ("M-C-S-m", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-umount.sh")
        , ("M-C-e", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-edit-configs.sh")
        , ("M-C-c", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-calc.sh")
        , ("M-C-S-s", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-scrot.sh")
        , ("M-C-u", spawn "/bin/sh ~/.config/dmenu/scripts/dmenu-unicode.sh")

        , ("C-e e", spawn "emacsclient -c -a 'emacs'")       
        , ("C-e b", spawn "emacsclient -c -a 'emacs' --eval '(ibuffer)'") 
        , ("C-e d", spawn "emacsclient -c -a 'emacs' --eval '(dired nil)'")
        , ("C-e n", spawn "emacsclient -c -a 'emacs' --eval '(elfeed)'")  
        , ("C-e s", spawn "emacsclient -c -a 'emacs' --eval '(eshell)'")

        , ("<XF86AudioMute>",   spawn "pulsemixer --toggle-mute")
        , ("<XF86AudioLowerVolume>", spawn "pulsemixer --change-volume -2")
        , ("<XF86AudioRaiseVolume>", spawn "pulsemixer --change-volume +2 && pulsemixer --max-volume 100")
        , ("<XF86AudioPlay>", spawn "playerctl -p spotify play-pause")
        , ("<XF86AudioStop>", spawn "playerctl -p spotify stop")
        , ("<XF86AudioPrev>", spawn "playerctl -p spotify previous")
        , ("<XF86AudioNext>", spawn "playerctl -p spotify next")
        ]

          ++ [("M-S-" ++ k, S.promptSearch jacksonXPConfig' f) | (k,f) <- searchList ]
        -- ++ [("M-S-s-" ++ k, S.selectSearch f) | (k,f) <- searchList ]

main :: IO ()
main = do

    xmproc0 <- spawnPipe "xmobar -x 0 /home/jackson/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "xmobar -x 1 /home/jackson/.config/xmobar/xmobarrc1"
    xmproc2 <- spawnPipe "xmobar -x 2 /home/jackson/.config/xmobar/xmobarrc2"

    xmonad $ ewmh def
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks
        -- Run xmonad commands from command line with "xmonadctl command". Commands include:
        -- shrink, expand, next-layout, default-layout, restart-wm, xterm, kill, refresh, run,
        -- focus-up, focus-down, swap-up, swap-down, swap-master, sink, quit-wm. You can run
        -- "xmonadctl 0" to generate full list of commands written to ~/.xsession-errors.

    -- Launching three instances of xmobar on their monitors.
    -- the xmonad, ya know...what the WM is named after!
        , handleEventHook    = serverModeEventHookCmd
                               <+> serverModeEventHook
                               <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
                               <+> docksEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor

        , logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x >> hPutStrLn xmproc2 x
                        , ppCurrent = xmobarColor "#51afef" "" . wrap "[" "]"
                        , ppVisible = xmobarColor "#c678dd" ""
                        , ppHidden = xmobarColor "#98be65" "" . wrap "*" ""
                        , ppHiddenNoWindows = xmobarColor "#dfdfdf" ""
                        , ppTitle = xmobarColor "#ff6c6b" "" . shorten 60 
                        , ppSep =  "<fc=#bbc2cf> <fn=2>|</fn></fc> "
                        , ppUrgent = xmobarColor "#ff6c6b" "" . wrap "!" "!"
                        , ppOrder  = \(ws:l:t) -> [ws]++t
                        }
        } `additionalKeysP` myKeys
