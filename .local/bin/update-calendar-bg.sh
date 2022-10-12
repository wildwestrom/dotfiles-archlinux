#!/usr/bin/env sh

debug_file=/tmp/update-calendar-sh-debug
rm -f $debug_file

dbg() {
	if [ -n "$DEBUG" ]; then
		echo "[$(date -uIns)] $1: $2" >>"$debug_file"
	else
		:
	fi
}

dbg "\$HOME" "$HOME"
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
dbg "\$XDG_DATA_HOME" "$XDG_DATA_HOME"

birthday_file=$XDG_DATA_HOME/birthday

if not [ -e "$birthday_file" ]; then
	zenity --info --text "Looks like you haven't put in a birthday yet"
	zenity --calendar --text "Put in a birthday" \
		--day=1 --month=1 --year=1970 \
		--date-format "%Y-%m-%d" \
		>"$birthday_file"
fi

current_bg=$XDG_DATA_HOME/current-bg
dbg "BG File" "$current_bg"
# shellcheck disable=SC2016
dbg '$(cat "$birthday_file")' "$(cat "$birthday_file")"

# ~/.local/bin/death-calendar img "$(cat "$birthday_file")" --lifespan-years=100 --scale-factor=2 --color-primary=64727D --color-secondary=2D3436 -o "$current_bg" log --width-height-ratio=8
~/.local/bin/death-calendar img "$(cat "$birthday_file")" --lifespan-years=100 -o "$current_bg" --scale-factor=2 --color-primary=64727D --color-secondary=2D3436 grid --stroke=1 --padding=1 --length=6 --border=2 --border-unit=shape --week-shape=circle

killall --signal 15 swaybg
swaybg -i "$current_bg" -m fit -c '#2D3436' &
