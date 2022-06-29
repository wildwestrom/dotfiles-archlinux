#!/usr/bin/env fish

argparse h/help s/slurp l/loop v/vertical -- $argv

# Display usage/help.
if set -q _flag_h
    echo "Usage: sg-ocr [OPTION]"
    echo -e "Tool for copying an area of the screen and reading text.\n"
    echo -e "  -h, --help\tDisplay this help menu."
    echo -e "  -s, --slurp\tCapture a specific area."
    echo -e "  -l, --loop\tLoop this script every 3 seconds."
    echo -e "  -v, --vertical\tOCR on vertical text instead of horizontal text."
    exit 0
end

# If the flag is set, then you can pick an area.
if set -q _flag_s
    set sg_capture_area (slurp)
    echo $sg_capture_area > /tmp/sg_cap_area
# If the flag is not set...
else
    # If /tmp/sg_cap_area exists
    if test -e /tmp/sg_cap_area
        # Set the area to the file
        set sg_capture_area (cat /tmp/sg_cap_area)
    else
        # set the area to a selection
        set sg_capture_area (slurp)
        # and save the area to that file
        echo $sg_capture_area > /tmp/sg_cap_area
    end
end

if set -q _flag_v
    set direction "-v"
else
    set direction "-h"
end


# The OCR Function.
function ocr
    # Capture an area of the screen.
    grim -g $sg_capture_area -t png /tmp/sg-img
    # grim -g $sg_capture_area -t png /dev/stdout \
    # | magick \
    #     fd:0 \
    #     -level 65%,80%,1.0 \
    #     -level 0%,0%,1.0 \
    #     -colorspace RGB \
    #     -format png \
    #     /tmp/sg-img
    # Use gazou's amazing OCR and copy to Wayland clipboard.
    gazou $direction /tmp/sg-img | tr -d "\n" | wl-copy
end

### Main Entry Point ###
ocr
# Loops if the -l flag is set.
while set -q _flag_l
    sleep 3s
    ocr
end
