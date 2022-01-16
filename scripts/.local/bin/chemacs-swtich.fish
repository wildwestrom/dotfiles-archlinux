#!/usr/bin/env fish

set profile_file $XDG_CONFIG_HOME/chemacs/profile

if count $argv > /dev/null
    echo "Set emacs profile to $argv[1]."
    echo $argv[1] > $XDG_CONFIG_HOME/chemacs/profile
else
    echo "Use this script to change chemacs profiles.
    chemacs-switch.fish [PROFILE_NAME]
    "
    echo "Your profile is currently set to:"
    bat -p $XDG_CONFIG_HOME/chemacs/profile
    echo "Here's your current profiles.el file:"
    bat -p $XDG_CONFIG_HOME/chemacs/profiles.el
end
