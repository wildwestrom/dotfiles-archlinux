#!/usr/bin/env fish

if set updates (checkupdates)
    notify-send -t 10000 -a 'checkupdates' \
        "You Have System Updates" \
        "You should probably update your packages."
end
