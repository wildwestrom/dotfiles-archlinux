#!/usr/bin/env fish

echo "I'm doing something dangerous at the moment"
echo "Don't use this."
exit
# don't do anything for now

set starting_dir $PWD

cd $HOME/.dotfiles
### INSIDE DOTFILE_DIR

for dir in (/bin/ls -d */)
    /usr/bin/stow -vS --dotfiles $dir
end

cd $starting_dir
### OUTSIDE DOTFILE_DIR
