#!/usr/bin/env fish

if not fish_is_root_user
    echo "Must be root to execute."
    exit 1
end

cd "/etc/NetworkManager/system-connections"

set surfshark_authinfo "/etc/openvpn/client/surfshark_authinfo"

set username (sed -n '1p' $surfshark_authinfo)
set password (sed -n '2p' $surfshark_authinfo)

function add-username
    if not crudini --get $argv[1] vpn username 2>&1 > /dev/null
        crudini --set $argv[1] vpn username
        crudini --set $argv[1] vpn username $username
    end
end

function add-password
    if not crudini --get $argv[1] vpn-secrets password 2>&1 > /dev/null
        crudini --set $argv[1] vpn-secrets password
        crudini --set $argv[1] vpn-secrets password $password
    end
end

function add-info
    add-username $argv[1]
    add-password $argv[1]
    sed -i -E "s/(\S*)\s*=\s*(.*)/\1=\2/g" $argv[1]
end

for f in (ls *surfshark*.nmconnection)
    echo $f
    add-info $f
end
