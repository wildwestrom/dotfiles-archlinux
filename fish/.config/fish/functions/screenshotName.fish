#!/usr/bin/env fish


# Only works for png images for now
function screenshotName
    if not $SCREENSHOT_DIR
        set SCREENSHOT_DIR "$HOME/images/screenshots"
    end

    echo $SCREENSHOT_DIR/screenshot-(date -u --iso-8601=seconds).png
end
