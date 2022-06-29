#!/usr/bin/env fish

set surfshark_authinfo "surfshark_authinfo"
set replacement_expression "auth-user-pass $surfshark_authinfo"

function checkAuthInfoStr
    grep --quiet $replacement_expression $argv[1]
end

function addAuthInfo
    sed -E -i \
    "s|auth-user-pass|$replacement_expression|g" \
    $argv[1]
end

set restart_script "script-security 2
up /usr/bin/update-systemd-resolved
up-restart
down /usr/bin/update-systemd-resolved
down-pre"

function checkRestartScript
    pcregrep -M --quiet $restart_script $argv[1]
end

function addRestartScript
    sed -i (echo -s "s|\(<ca>\)|"(string escape $restart_script )"\n\n\1|") $argv[1]
end

for f in *.ovpn
    if not checkAuthInfoStr $f
        addAuthInfo $f
    end
    if not checkRestartScript $f
        addRestartScript $f
    end
end
