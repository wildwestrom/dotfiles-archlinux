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

coordinates_dir=$XDG_DATA_HOME/coordinates

if not [ -e "$coordinates_dir" ]; then
	mkdir "$coordinates_dir"
fi

lat_file=$coordinates_dir/lat
lon_file=$coordinates_dir/lon

if not [ "$(find "$coordinates_dir" | wc -l)" -eq 3 ]; then
	zenity --info --text "Looks like you haven't added your coordinates."
	"$HOME/.local/bin/register_coordinates.sh"
fi

# shellcheck disable=SC2016
dbg '$(cat "$lat_file")' "$(cat "$lat_file")"
# shellcheck disable=SC2016
dbg '$(cat "$lon_file")' "$(cat "$lon_file")"

wlsunset -T 6500 -t 4000 -l "$(cat "$lat_file")" -L "$(cat "$lon_file")"
