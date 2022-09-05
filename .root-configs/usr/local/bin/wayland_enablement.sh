#!/bin/sh
export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland-egl
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
# I couldn't find any other solution to make GTK apps behave. If you can come up
# with something better, please let me know.
export GTK_THEME=Adwaita:dark
