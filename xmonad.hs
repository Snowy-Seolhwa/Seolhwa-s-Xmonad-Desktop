{-
 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |    _______   | || |  _________   | || |     ____     | || |   _____      | || |              | |
| |   /  ___  |  | || | |_   ___  |  | || |   .'    `.   | || |  |_   _|     | || |              | |
| |  |  (__ \_|  | || |   | |_  \_|  | || |  /  .--.  \  | || |    | |       | || |    ______    | |
| |   '.___`-.   | || |   |  _|  _   | || |  | |    | |  | || |    | |   _   | || |   |______|   | |
| |  |`\____) |  | || |  _| |___/ |  | || |  \  `--'  /  | || |   _| |__/ |  | || |              | |
| |  |_______.'  | || | |_________|  | || |   `.____.'   | || |  |________|  | || |              | |
| |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
 .----------------.  .----------------.  .-----------------. .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| | ____    ____ | || |     ____     | || | ____  _____  | || |      __      | || |  ________    | |
| ||_   \  /   _|| || |   .'    `.   | || ||_   \|_   _| | || |     /  \     | || | |_   ___ `.  | |
| |  |   \/   |  | || |  /  .--.  \  | || |  |   \ | |   | || |    / /\ \    | || |   | |   `. \ | |
| |  | |\  /| |  | || |  | |    | |  | || |  | |\ \| |   | || |   / ____ \   | || |   | |    | | | |
| | _| |_\/_| |_ | || |  \  `--'  /  | || | _| |_\   |_  | || | _/ /    \ \_ | || |  _| |___.' / | |
| ||_____||_____|| || |   `.____.'   | || ||_____|\____| | || ||____|  |____|| || | |________.'  | |
| |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'

####################################################################################################

Hello! Welcome to Seolhwa's Xmonad configuration file. This configuration is designed to be
minimalistic, aesthetically pleasing, and functional.
Some of the keybindings are designed to take advantage of the media keys on a
Thinkpad T530, but these can be changed to other keybindings or to other XF86 keys.

I use this configuration with the matching dotfiles for Xmobar, picom, kitty, bash profile,
and dmenu (with the center, border, case-insensitive, and mouse support patches).
I also pair this WM setup with the Tela-Grey icon set, Equilux Dark theme, Posy's Cursor set, and
Monoid fonts.

####################################################################################################

-}

import XMonad

import XMonad.ManageHook --adds some operators like =? (which means if thing equals thing, return true)

import XMonad.StackSet as W --adds the rationalRect thing from the scratchpad section, allows for
--windows to be placed according to fractions and ratios of the screen's size

import XMonad.Hooks.DynamicLog --everything below is stuff for getting the status bar log working
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops --required for fullscreen

import XMonad.Util.EZConfig --EZconfig makes the keybindings less annoying to write out
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce --lets xmonad start stuff when it launches
import XMonad.Util.Ungrab --comment out if using an up to date xmonad install (0.18), it comes free with your fucking xbox
import XMonad.Util.NamedScratchpad --timeout corner for windows that I don't want clogging up my workspaces

import XMonad.Layout.NoBorders --allows you to turn off borders for floating windows and fullscreen
import XMonad.Layout.Spacing --lets you have pretty window gaps
import XMonad.Layout.Renamed --lets you rename the layouts as they get sent to the status bar
import XMonad.Layout.Grid --a nice even grid tiling algorithm
import XMonad.Layout.BinarySpacePartition --algorithm that lets you split windows in half (like bspwm)
import XMonad.Layout.LayoutCombinators --has a thing that lets you keybind to specific layouts
import XMonad.Layout.ThreeColumns --three columns, this is useful for coding and stuff with documentation open in another window
import XMonad.Layout.Magnifier --magnifier is applied to three columns, so when the columns are are there and the windows are a little thin, whatever is focused is automatically magnified

import XMonad.Actions.Navigation2D --lets you hop around windows and screens with arrow keys as if you were on a coordinate grid, rather than cycling between windows in a set order with mod+tab

import Graphics.X11.ExtraTypes.XF86 --lets you keybind to stuff like media keys and macro keys et.c

main :: IO ()
main = xmonad --main function pretty much holds everything that is going to get run by Xmonad
     . ewmhFullscreen --lets xmonad process software requests to fullscreen, so nothing crashes
     . ewmh --extended window manager hints, lets xmonad get more window input from software
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey --status bar shit idk
     . withNavigation2DConfig myNavigation2DConfig --lets xmonad access the 2Dnavigation function for moving with the arrow keys using a custom config 'myNavigation2DConfig'
     $ myConfig --loads the myConfig section thats below this

{-
Quick haskell note <3

"." means the same thing as f(g(x)) in math, so you're inputting a function into another function,
in the above case its just giving the functions that I've chosen to the main program so it can use them

"$" is used instead of parenthesis, so  (1 + (1 * 3) can be written as $ 1 + $ 1 * 3

while ewmhFullscreen, ewmh, and withEasySB are all functions being plugged into the main function,
myConfig is not really a function it's just a list of variables (some of the variables in it are also lists
of variables)
-}

myConfig = def
    { modMask     = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook  = myLayout      -- Use custom layouts
    , manageHook  = myManageHook  -- Match on certain windows
    , startupHook = myStartupHook -- Start stuff on launch
    , terminal = "kitty" --this is where you choose a terminal
    , borderWidth = 2 --the borders that go around windows
    , normalBorderColor = "#000000" --border color when you aren't hovering over it with the mouse
    , focusedBorderColor = "#FFFFFF" --border color when you are
    }
  `additionalKeysP` --this uses the EZconfig library so keybinds are shorter and more readable
    [ ("M-S-z", spawn "xscreensaver-command -activate") --turns on the screensaver
    , ("M-<Print>", unGrab *> spawn "scrot ~/Multimedia/Pictures/Screenshots/screenshot.png"        ) --lets you take a screenshot
    , ("M-S-<Print>", unGrab *> spawn "scrot -s ~/Multimedia/Pictures/Screenshots/screenshot.png"        ) --lets you choose part of the screen to screenshot
    , ("M-C-1", sendMessage $ JumpToLayout "Tiled") --chooses one main window and tiles the rest to the side
    , ("M-C-2", sendMessage $ JumpToLayout "Mirror Tiled") --same thing but vertical
    , ("M-C-3", sendMessage $ JumpToLayout "Full") --makes a window take up all of space
    , ("M-C-4", sendMessage $ JumpToLayout "Grid") --makes a grid of windows
    , ("M-C-5", sendMessage $ JumpToLayout "ThreeCol") --three columns with the middle magnified
    , ("M-C-6", sendMessage $ JumpToLayout "BSP") --lets you split windows in half
    , ("M-<F8>", spawn "xbacklight -dec 5%") --increase and decrease the screen brightness
    , ("M-<F9>", spawn "xbacklight -inc 5%")
    --TODO: change this to pipewire controls
    , ("<XF86AudioLowerVolume>", spawn "/usr/bin/amixer set Master 5%-") --increase, decrease, mute, and mic mute
    , ("<XF86AudioRaiseVolume>", spawn "/usr/bin/amixer set Master 5%+")
    , ("<XF86AudioMute>", spawn "/usr/bin/amixer set Master toggle")
    , ("<XF86AudioMicMute>", spawn "amixer set Capture toggle")
    , ("<XF86Launch1>", spawn "emacs") --use the thinkpad media keys to launch my most used programs
    , ("M-<XF86Launch1>", spawn "firefox")
    , ("M-S-<XF86Launch1>", spawn "nemo")
    , ("M-<Control_R>", namedScratchpadAction myScratchpads "discord") --spawns discord if its not open and pops it in and out of the discord scratchpad
    , ("M-<Alt_R>", allNamedScratchpadAction myScratchpads "audacious") --spawns audacious if its not open and pops ALL of its windows in and out of the audacious scratchpad
    , ("M-S-/", spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) --sends the keybinding message listed at the bottom of the file
    , ("M-p", spawn "rofi -show run -font 'Monoid 11' ") --uses rofi to launch programs instead of dmenu, because its way less annoying and way better lmao
    , ("M-/", spawn "dunstctl set-paused toggle") --toggle desktop notifications
    --2D navigation keybindings
    -- Switch between layers
    , ("M-C-<Space>", switchLayer)

    -- Directional navigation of windows
    , ("M-<Right>", windowGo R True)
    , ("M-<Left>", windowGo L True)
    , ("M-<Up>", windowGo U True)
    , ("M-<Down>", windowGo D True)

    -- Swap adjacent windows
    , ("M-C-<Right>", windowSwap R True)
    , ("M-C-<Left>", windowSwap L True)
    , ("M-C-<Up>", windowSwap U True)
    , ("M-C-<Down>", windowSwap D True)

    -- Directional navigation of screens
    , ("M-S-<Right>", screenGo R False)
    , ("M-S-<Left>", screenGo L False)
    , ("M-S-<Up>", screenGo U False)
    , ("M-S-<Down>", screenGo D False)

    -- Swap workspaces on adjacent screens
    , ("M-S-r", screenSwap R False)
    , ("M-S-l", screenSwap L False)
    , ("M-S-u", screenSwap U False)
    , ("M-S-d", screenSwap D False)

    -- Send window to adjacent screen
    , ("M-C-r", windowToScreen R False)
    , ("M-C-l",  windowToScreen L False)
    , ("M-C-u", windowToScreen U False)
    , ("M-C-d", windowToScreen D False)
    ]

--2D navigation behavior configuration
myNavigation2DConfig = def { layoutNavigation   = [("Full", centerNavigation) --the two lines starting with full let you switch between open windows with the arrow keys in the full layout
                                                  ,("BSP", sideNavigationWithBias 1) -- of the lines which say sideNavigationWithBias are explaining how the function chooses which window
                                                  ,("Grid", sideNavigationWithBias 1) -- to open based on the direction provided by the arrow keys
                                                  ,("Tiled", sideNavigationWithBias 1) -- if you don't have this, you cannot move to a window that is not perfectly lined up with the focused window
                                                  ,("Mirror Tiled", sideNavigationWithBias 1) -- this one resolves that conflict, it can be a little janky if you have a lot of weird
                                                  ,("ThreeCol", sideNavigationWithBias 1)] -- windows open, but you can also use mod+tab and mod+shift+tab to cycle through normally.
                           , unmappedWindowRect = [("Full", singleWindowRect)]
                           }

--this is my list of scratchpads and their associated rules
myScratchpads :: [NamedScratchpad] --tells xmonad that this list is of the type NamedScratchpad
myScratchpads = [NS "discord" "discord" (appName =? "discord") (customFloating $ W.RationalRect (1/10) (1/10) (4/5) (4/5)) , --floats discord in screen middle with 4/5 of its width and height
                 NS "audacious" "audacious" (appName =? "audacious") defaultFloating  --floats audacious whereever
                ] where role = stringProperty "WM_WINDOW_ROLE"

myManageHook :: ManageHook --manage hook is a list of rules for how programs and windows are treated based on
myManageHook = composeAll --what they are and what type of thing they are
    [ isDialog            --> doFloat
    , resource =? "kdesktop" --> doIgnore
    , resource =? "desktop_window" --> doIgnore
    , namedScratchpadManageHook myScratchpads --allows Xmonad to access my list of scratchpads and their rules
    ] --all of these basically just keep pop-ups from getting crammed into the window tiles and glitching out

--myLayout is a list of all the layouts I have installed
--lessBorders OnlyFloat removes the borders from floating windows and fullscreens
--renamed [CutWordsLeft 1] removes an annoying piece of text that says "spacing" that gets sent to the status bar layout title
--spacing 12 makes the window gaps 12 pixels all around each window all the time
--the rest is literally just listing what layouts are available to switch between and in what order they cycle with mod+space
myLayout = lessBorders OnlyFloat $ renamed [CutWordsLeft 1] $ spacing 12 (tiled ||| Mirror tiled ||| Full ||| Grid ||| threeCol ||| emptyBSP)
  where
    threeCol
             = renamed [Replace "ThreeCol"] --changes the name of the Three column layout
             $ magnifiercz' 1.3 --adds magnifier by 1.3x to the focused window only in the three column layout
             $ ThreeColMid nmaster delta ratio --defines three column behavior
    tiled    = renamed [Replace "Tiled"] $ Tall nmaster delta ratio --tells tiles layout how to work and names it "Tiled" on the status bar
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

--all the stuff that xmonad will try to run on startup rather than having to put it individually into the .profile .xinitrc or something
--feh is for wallpaper, picom is for window transparency and other window effects, xsetroot makes the system use your
--chosen cursor theme from lxappearance instead of the ugly X windows x cursor
--I like to run emacs on startup because I have my to do list in there so I'm reminded whenever i start my computer or recompile xmonad
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "feh --bg-scale ~/Multimedia/Wallpapers/cyberware.png &"
    spawnOnce "picom &"
    spawnOnce "emacs &"
    spawnOnce "xsetroot -cursor_name left_ptr &"
    spawnOnce "dunst &" --notifications
    spawnOnce "fcitx5 -d &" --language input (hangul in my case)

--this part modifies the output to the status bar when the scratchpads are active and hidden, letting you know something is there
--my understanding of this is fuzzy, but I think the customRename function takes two inputs: a String and a WindowSpace,
--and outputs another String as the name to change the first String to.
--(I'm not sure about this) WindowSpace is a type alias for a String representing the workspace ID, and is apparently a reader monad,
--I guess this means that it exists to pass data between functions that don't necessarily need to alter or use that data beyond passing on to another one
--Regardless the _ means that that is ignored setting "NSP", the thing that is there by default with a named scratchpad, with the heart symbol,
--because it's cuter and less random text on my bar.
-- ws _ = ws just keeps all of the other workspace info the same as normal (so workspaces 1-9 show up as "1 2 ... | layoutName")
customRename :: String -> WindowSpace -> String
customRename "NSP" _ = "*"
customRename ws _ = ws

--this determines all of the stuff that gets sent to the status bar part of xmobar
--PP stands for pretty printing, its basically just stuff that makes the output into xmobar look nicer
myXmobarPP :: PP
myXmobarPP = def
    { ppSep     = " | " --puts a bar spacer in between all the stuff it sends to the status log
    , ppCurrent = wrap " " "" . xmobarBorder "Top" "#000000" 3 --puts a little black marker above the workspace number that is currently in use
    , ppOrder = \(ws:l:_:_) -> [ws,l] --chooses workspace numbers and the layout mode for the two things to display, and puts them next to each other
    , ppRename = customRename --uses ppRename to rename stuff that is outputted to the status bar based on our customRename function
    }

--If you press mod+shift+/ you'll get a text window popup with everything written below, which is keybindings
help :: String
help = unlines ["The modifier key is 'Super/Windows'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch terminal",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging",
    "mod-shift-button3 Set a floating window back to tiling mode using mouse buttons",
    "",
    "--Seolmonad bindings",
    "mod-p  run rofi program launcher",
    "mod-Shift-z  blank xscreensaver",
    "mod-PrintScreen  take a screenshot with scrot",
    "mod-Shift-PrintScreen  take a custom sized screenshot with scrot",
    "mod-Control-(1-6)  switch layout directly to a specific one [1-tiled, 2-mirror-tiled, 3-full, 4-grid, 5-magnified three column, 6 binary space partition]",
    "mod-f8  Subtracts 10% brightness from the screen",
    "mod-f9  Adds 10% brightness to the screen",
    "mod-right control  Pops discord in and out of its scratchpad",
    "mod-right alt  Pops winamp (audacious) in and out of its scratchpad",
    "mod-/  toggles desktop notifications",
    "thinkvantage  Opens emacs",
    "mod-thinkvantage  Opens qutebrowser",
    "mod-shift-thinkvantage  Opens nemo file browser",
    "media keys  mutes mic, speakers, and changes volume as expected",
    --2D navigation
    "mod-control-Space  switch between window layers",
    "mod-arrow keys  switch between windows using 2D navigation",
    "mod-control-arrow keys  switch adjacent windows",
    "mod-shift-arrow keys  switch between adjacent screens using 2D navigation",
    "mod-shift-rlud  swap workspaces on adjacent screens",
    "mod-control-rlud  send window to adjacent screen"
    ]
