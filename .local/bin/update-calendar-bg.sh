#!/usr/bin/env sh

debug_file=/tmp/update-calendar-sh-debug

if [ -n "$DEBUG" ]; then
	echo "Date:" "$(date -uIs)" >"$debug_file"
else
	:
fi

dbg() {
	if [ -n "$DEBUG" ]; then
		echo "$1: $2" >>"$debug_file"
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
dbg '$(cat "$birthday_file")' "$(cat "$birthday_file")"

~/.local/bin/death-calendar svg "$(cat "$birthday_file")" --scale-factor=2 --border-unit=shape --shape=circle --lifespan-years=75 --ratios=1,1,6,2 >"$current_bg"
killall --signal 15 swaybg
swaybg -i "$current_bg" -m fit -c '#FFFFFF' &
