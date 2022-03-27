#!/usr/bin/env fish

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
    trash -v $argv
end
