#!/usr/bin/env fish

function open-imv
    imv -s full * -d
end

if test $argv[1]!=''
    if test -f $argv[1]
        set IMAGE (realpath $argv[1])
    else if test -d $argv[1]
        set IMAGE (cd $argv[1] && open-imv)
    end
else
    set DIR (fd . -t d -a $HOME | fzf)
    set IMAGE (cd $DIR && open-imv)
end

if test -z $IMAGE
    echo 'No image given.'
    exit 1
end

argparse --name=change-bg 'm/mode=' -- $argv

if set -q _flag_m
    set mode $_flag_m
else
    set mode 'fit'
end

command cp "$IMAGE" $XDG_DATA_HOME/current-bg
pkill --signal 15 swaybg
swaybg -i ~/.local/share/current-bg -m $mode >/dev/null 2>&1 &
