### ENVVARS
#
#

# Remove default greeing
set fish_greeting

set -x EDITOR "nvim"
set -x VISUAL "emacsclient -c -a emacs"
set -x READER "bat"

set -x GDK_BACKEND "wayland"

# User Path
fish_add_path -a "$HOME/.local/bin"

# Flatpak Path
fish_add_path -a "/var/lib/flatpak/exports/bin"

# GPG
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Screenshots
set -x SCREENSHOT_DIR "$HOME/images/screenshots"

# Java Applications
set -x _JAVA_AWT_WM_NONREPARENTING 1

set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

set -x NOTMUCH_CONFIG "$XDG_CONFIG_HOME/notmuch-config"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -x LESSHISTFILE "-"
set -x WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -x INPUTRC "$XDG_CONFIG_HOME/shell/inputrc"
set -x ALSA_CONFIG_PATH "$XDG_CONFIG_HOME/alsa/asoundrc"
# set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -x WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
set -x KODI_DATA "$XDG_DATA_HOME/kodi"
set -x PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -x TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -x ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x GOPATH "$XDG_DATA_HOME/go"
set -x ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible/ansible.cfg"
set -x HISTFILE "$XDG_DATA_HOME/history"
set -x WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
set -x MBSYNCRC "$XDG_CONFIG_HOME/mbsync/config"
set -x ELECTRUMDIR "$XDG_DATA_HOME/electrum"

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
alias l.="exa -d .*"
alias df='df -h'
alias du='du -ch'
alias cat="bat"

alias fishrc="$EDITOR $XDG_CONFIG_HOME/fish/config.fish"
alias termrc="$EDITOR $XDG_CONFIG_HOME/foot/foot.ini"
alias swayrc="$EDITOR $XDG_CONFIG_HOME/sway/config"
alias edviminit="$EDITOR $XDG_CONFIG_HOME/nvim/init.lua"


alias su="su -s /bin/fish"
alias brave="brave --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias proc="ps aux | grep -v grep | grep "
alias inx="MOZ_ENABLE_WAYLAND=0 GDK_BACKEND=X11 QT_QPA_PLATFORM=xcb WINIT_UNIX_BACKEND=x11 DISPLAY=:0"

# Vi bindings
function fish_user_key_bindings
  fish_vi_key_bindings
end
