#!/usr/bin/env fish
set starting_dir $PWD

cd $HOME/.dotfiles
### INSIDE DOTFILE_DIR

for dir in (/bin/ls -d */)
    stow -S $dir
end

cd $starting_dir
### OUTSIDE DOTFILE_DIR
