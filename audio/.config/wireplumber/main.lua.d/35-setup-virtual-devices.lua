-- we load this early as at stage 40 the restore-streams script is running and our virtual devices might be needed for that
load_script("wireplumber-virtual-devices.lua")
