#!/usr/bin/env fish

### This script is meant to help me
### unlearn the muscle memory of
### using `rm` for all my deletion needs.

function read_confirm
    while true
        read -l -P $argv confirm
        set confirm (string lower $confirm)

        switch $confirm
            case y yes
                return 0
            case '' n no
                return 1
        end
    end
end

if test (read_confirm "Are you sure you want to use rm to delete? (y/N): ")
    rm -iv $argv
else
    echo "Ok, use trash-cli instead."
end
