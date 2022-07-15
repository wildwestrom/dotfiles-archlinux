function gpg-fingerprint
    gpg --fingerprint $argv | sd '.+0x([A-F,0-9]+)\s.+' '$1' | head -n1
end

function gpg-pubkey
    gpg --export --armor $argv
end
