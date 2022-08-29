#!/usr/bin/env sh

debug_file=/tmp/set-location-sh-debug

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

coordinates_file=$XDG_DATA_HOME/coordinates

if not [ -e "$coordinates_file" ]; then
	zenity --info --text "Looks like you haven't added your coordinates"
	echo \
		"-l" \
		"$(zenity --entry --text "Put in your latitude (a number from -180 to +180).")" \
		"-L" \
		"$(zenity --entry --text "Put in your longitude (a number from -180 to +180).")" \
		>"$coordinates_file"
fi

# shellcheck disable=SC2016
dbg '$(cat "$coordinates_file")' "$(cat "$coordinates_file")"

wlsunset -T 6500 -t 4000 "$(cat "$coordinates_file")"
