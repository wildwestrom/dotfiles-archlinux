#!/usr/bin/env sh

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
coordinates_dir=$XDG_DATA_HOME/coordinates

if not [ -e "$coordinates_dir" ]; then
	mkdir "$coordinates_dir"
fi

lat_file=$coordinates_dir/lat
lon_file=$coordinates_dir/lon

zenity --entry --text "Put in your latitude (a number from -180 to +180)." >"$lat_file"
zenity --entry --text "Put in your longitude (a number from -180 to +180)." >"$lon_file"
