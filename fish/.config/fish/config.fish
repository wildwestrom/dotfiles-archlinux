### ENVVARS

# Remove default greeing
set fish_greeting

# Editors/Readers
set -gx EDITOR "swayhide emacsclient -c"
set -gx READER "bat"

# XDG_DIRS
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

### PATH
# User Path
fish_add_path -a "$HOME/.local/bin"

# Flatpak Path
fish_add_path -a "/var/lib/flatpak/exports/bin"

# GPG
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Screenshots
set -gx SCREENSHOT_DIR "$HOME/images/screenshots"

# Java Applications
set -gx _JAVA_AWT_WM_NONREPARENTING 1

# Android
fish_add_path -a "/opt/android-sdk/platform-tools"

# Node.js
set -gx NVM_DIR "$XDG_CONFIG_HOME/nvm"
set -gx NPM_PACKAGES "$XDG_DATA_HOME/npm-packages"
set -gx NODE_PATH "$NPM_PACKAGES/lib/node_modules"
fish_add_path -a "$NPM_PACKAGES/bin"
set -gx MANPATH ":$NPM_PACKAGES/share/man"
set -gx nvm_prefix $NVM_DIR

# Haskell
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; fish_add_path -a $HOME/.cabal/bin $HOME/.ghcup/bin

# Cleanup
set -gx IPFS_PATH "$XDG_DATA_HOME/ipfs"
set -gx NOTMUCH_CONFIG "$XDG_CONFIG_HOME/notmuch-config"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -gx LESSHISTFILE "-"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -gx INPUTRC "$XDG_CONFIG_HOME/shell/inputrc"
set -gx ALSA_CONFIG_PATH "$XDG_CONFIG_HOME/alsa/asoundrc"
# set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
set -gx KODI_DATA "$XDG_DATA_HOME/kodi"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -gx ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible/ansible.cfg"
set -gx HISTFILE "$XDG_DATA_HOME/history"
set -gx WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
set -gx MBSYNCRC "$XDG_CONFIG_HOME/mbsync/config"
set -gx ELECTRUMDIR "$XDG_DATA_HOME/electrum"

### Aliases
alias v=$EDITOR

alias cp="cp -iv"
alias mv="mv -iv"
alias ln="ln -iv"
alias rm="rm -iv"
alias trash="trash -v"
alias mkdir="mkdir -pv"
alias stow="stow -v"

alias ls="exa --color=always"
alias ll="exa -la --color=always"
alias la="exa -a --color=always"
alias lt="exa -aT --color=always"
alias l.="exa -d .*"
alias df='df -h'
alias du='du -ch'
alias fd='fd --hidden'
alias rg='rg -.'
alias ag='ag -a'
alias cat="bat"
alias less="bat"
alias tree="tree -a"

alias fishrc="$EDITOR $XDG_CONFIG_HOME/fish/config.fish"
alias termrc="$EDITOR $XDG_CONFIG_HOME/foot/foot.ini"
alias swayrc="$EDITOR $XDG_CONFIG_HOME/sway/"
alias kanshirc="$EDITOR $XDG_CONFIG_HOME/kanshi/config"
alias barrc="$EDITOR $XDG_CONFIG_HOME/waybar/config"
alias vimrc="$EDITOR $XDG_CONFIG_HOME/nvim/"

alias su="su -s /bin/fish"
alias htop="htop -s PERCENT_CPU"
alias proc="ps aux | grep -v grep | grep "
alias inx="MOZ_ENABLE_WAYLAND=0 GDK_BACKEND=X11 QT_QPA_PLATFORM=xcb WINIT_UNIX_BACKEND=x11 DISPLAY=:0"
alias magit='swayhide emacsclient -c --eval "(magit-status-here)"'
alias mpv="swayhide mpv"
alias imv="swayhide imv"

# Vi bindings
function fish_user_key_bindings
  fish_vi_key_bindings
end
