#!/usr/bin/env fish

if fish_is_root_user
    grub-install --efi-directory=/boot --target=x86_64-efi
else
    echo "You must be root to execute this script"
end
