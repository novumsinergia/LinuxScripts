#!/bin/sh
#firstly you have to create your shortcuts, then you have to substitute them in this script to match yours, done
yad --width=720 --height=550 \
--center \
--window-icon="/usr/share/pixmaps/keyboard_shortcut.svg" \
--title="Keybindings" \
--no-buttons \
--list \
--column=Key: \
--column=Description: \
--column=Command: \
--timeout=120 \
--timeout-indicator=right \
"Help" "" "?" \
"Firstly you have to create your shortcuts," "then you have to substitute them, in this script," "to match yours, done" \
"______________________________________" "____________________________________________" "____________________" \
"ESC" "close this app" "" \
"=" "modkey" "(set mod Mod4)" \
"ctrl+t" "Terminal" "(LXTerminal)" \
"ctrl+o" "" "Open Broswer" \
"ctrl+n" "" "Open Files" \
"alt+f4" "close focused app" "(kill)" \
"Print" "screenshot app" "(take a shot)" \
"ctrl+g" "text editor" "(geany)" \
"ctrl+d" "set date and time" "(set-time-for-puppy)" \
"shift+up" "move to up window" "" \
"shift+down" "move to down window" "" \
"shift+left" "move to left window" "" \
"shift+right" "move to right window" "" \
"alt+insert" "add workspace" "" \
"alt+delete" "delete last workspace" "" \
"" "" "     Window closes in 120 sec."\
