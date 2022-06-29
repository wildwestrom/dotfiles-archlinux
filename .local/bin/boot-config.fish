#!/usr/bin/env fish

if fish_is_root_user
    mkinitcpio -P
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "You must be root to execute this script"
end
