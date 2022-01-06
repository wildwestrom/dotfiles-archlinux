#!/usr/bin/env fish

#grim -g
#(
swaymsg -t get_outputs -r | jq -r '.[] | select(.focused) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -d
#)

#(screenshotName)
