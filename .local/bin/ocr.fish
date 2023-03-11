#!/usr/bin/env fish

argparse h/help l/language -- $argv

# Display usage/help.
if set -q _flag_h
    echo "Usage: de-ocr [OPTION]"
    echo -e "Tool for copying an area of the screen and copying german text.\n"
    echo -e "  -h, --help\tDisplay this help menu."
    echo -e "  -l, --language\tChoose the language to OCR (tesseract --list-langs)."
    exit 0
end

if not set -q _flag_l
  set _flag_l (cat $XDG_DATA_HOME/ocr-lang)
end

set ocr_capture_area (slurp)
echo $ocr_capture_area > /tmp/ocr_cap_area

# The OCR Function.
function ocr
    # Capture an area of the screen.
    grim -g $ocr_capture_area -t png /dev/stdout \
    | magick \
        fd:0 \
        -level 65%,80%,1.0 \
        -level 0%,0%,1.0 \
        -colorspace RGB \
        -format png \
        /tmp/ocr-img \
    | tesseract /tmp/ocr-img stdout -l $_flag_l \
    | tr "\n" " " \
    | tr -d " " \
    | wl-copy
end

### Main Entry Point ###
ocr
