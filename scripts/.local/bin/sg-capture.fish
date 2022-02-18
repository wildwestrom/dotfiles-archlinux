#!/usr/bin/env fish

argparse s/slurp l/loop b/black-on-white w/white-on-black -- $argv

if set -q _flag_s
    set area (slurp)
else
    set area "0,760 1920x229"
end

function cap-area
    grim -g $area -t png /dev/stdout
end

function tesser-and-trim
    tesseract - - -l jpn \
        | tr "\n" " " \
        | sed "s/\s//g"
end

function ocr-wob
    cap-area \
        | magick \
        fd:0 \
        -filter Mitchell -resize 300% \
        -level 65%,80%,1.0 \
        -colorspace LinearGray \
        -level 0%,0%,1.0 \
        -bordercolor White \
        -border 10x10 \
        /dev/stdout \
        | tesser-and-trim
end

function ocr-bow
    cap-area \
        | magick \
        fd:0 \
        -filter Mitchell -resize 300% \
        -colorspace LinearGray \
        /dev/stdout \
        | tesser-and-trim
end

function ocr
    if set -q _flag_b
        ocr-bow
    else
        ocr-wob
    end
end

if set -q _flag_l
    set loop true
else
    set loop false
end

ocr | wl-copy
while $loop
    sleep 5s
    ocr | wl-copy
end
