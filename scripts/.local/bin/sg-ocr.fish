#!/usr/bin/env fish

argparse h/help s/slurp l/loop -- $argv

# If the flag is set, then you can pick an area.
if set -q _flag_s
    set area (slurp)
else
    set area "0,760 1920x229"
end

# Display usage/help.
if set -q _flag_h
    echo "Usage: sg-ocr [OPTION]"
    echo -e "Tool for copying an area of the screen and reading text.\n"
    echo -e "  -h, --help\tDisplay this help menu."
    echo -e "  -s, --slurp\tCapture a specific area."
    echo -e "  -l, --loop\tLoop this script every 3 seconds."
    exit 0
end

# The OCR Function.
function ocr
    # Capture an area of the screen.
    grim -g $area -t png /tmp/sg-img
    # Use gazou's amazing OCR and copy to Wayland clipboard.
    gazou -h /tmp/sg-img | tr -d "\n" | wl-copy
end

### Main Entry Point ###
ocr
# Loops if the -l flag is set.
while set -q _flag_l
    sleep 3s
    ocr
end
