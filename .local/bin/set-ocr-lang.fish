#!/usr/bin/env fish

set langs (ls /usr/share/tessdata/ | rg traineddata | sd '.traineddata' '')

set tesseract_language (zenity --list \
    --title="Select a language from the currently installed tesseract data." \
    --column="" --column "language" --radiolist $langs $langs)

echo $tesseract_language > $XDG_DATA_HOME/ocr-lang
echo "Set language to '$tesseract_language'"
