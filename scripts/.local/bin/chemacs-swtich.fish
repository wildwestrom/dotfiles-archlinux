#!/usr/bin/env fish


set usage "Use this script to change chemacs profiles:
    chemacs-switch.fish [PROFILE_NAME]"

if count $argv > /dev/null
    echo "Set emacs profile to $argv[1]."
    echo $argv[1] > $XDG_CONFIG_HOME/chemacs/profile
else
    echo $usage
end
