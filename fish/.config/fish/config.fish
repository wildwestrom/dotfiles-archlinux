
### ENVVARS
#
#

# Remove default greeing
set fish_greeting

set -x EDITOR "nvim"
set -x VISUAL "emacsclient -c -a emacs"
set -x READER "bat"

set -x GDK_BACKEND "wayland"

set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

# User Path
set -x PATH "$HOME/.local/bin" $PATH

# Flatpak Path
set -x PATH "/var/lib/flatpak/exports/bin" $PATH

# GPG
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

set SCREENSHOT_DIR "$HOME/images/screenshots"


### Aliases
#
#
alias v=$EDITOR

alias cp="cp -iv"
alias mv="mv -iv"
alias ln="ln -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"
alias stow="stow -v"

alias ls="exa --color=always"
alias ll="exa -la --color=always"
alias la="exa -a --color=always"
alias lt="exa -aT --color=always"
alias l.="exa -a | egrep '^\.'"
alias cat="bat"

alias fishrc="$EDITOR $XDG_CONFIG_HOME/fish/config.fish"
alias termrc="$EDITOR $XDG_CONFIG_HOME/foot/foot.ini"
alias swayrc="$EDITOR $XDG_CONFIG_HOME/sway/config"
alias edviminit="$EDITOR $XDG_CONFIG_HOME/nvim/init.lua"

alias su="su -s /bin/fish"
alias brave="brave --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias ps="ps aux | grep -v grep | grep "

# Vi bindings
function fish_user_key_bindings
  fish_vi_key_bindings
end
