### ENVVARS

# Remove default greeing
set fish_greeting

# Editors/Readers
set -gx EDITOR "swayhide emacsclient -c -a nvim"
# set -gx EDITOR "nvim"

set -gx READER "bat"

# Man Page Reader
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# XDG_DIRS
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_STATE_HOME "$HOME/.local/state"

### PATH
# User Path
fish_add_path -a "$HOME/.local/bin"

# Flatpak Path
fish_add_path -a "/var/lib/flatpak/exports/bin"

# GPG
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# Screenshots
set -gx SCREENSHOT_DIR "$HOME/images/screenshots"

# pass
set -gx PASSWORD_STORE_DIR "XDG_DATA_HOME/pass"

# wget
alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"

# wine
set -gx WINEPREFIX "$XDG_DATA_HOME/wine"

# zoom
set -gx SSB_HOME "$XDG_DATA_HOME/zoom"

# LaTeX
set -gx TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"

# JVM/JAVA/Clojure
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -gx LEIN_HOME "$XDG_DATA_HOME/lein"
set -gx _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# Android
set -gx ANDROID_HOME "$XDG_DATA_HOME/android"
set -gx ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
fish_add_path -a "/opt/android-sdk/platform-tools"

# Node.js
set -gx NVM_DIR "$XDG_DATA_HOME/nvm"
set -gx NPM_PACKAGES "$XDG_DATA_HOME/npm-packages"
set -gx NODE_PATH "$NPM_PACKAGES/lib/node_modules"
set -gx MANPATH ":$NPM_PACKAGES/share/man"
set -gx nvm_prefix $NVM_DIR
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
fish_add_path -a "$NVM_DIR/versions/node/v17.9.0/bin/"
set -gx PNPM_HOME "/home/main/.local/share/pnpm"
fish_add_path -a "$PNPM_HOME"

# Haskell
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx GHCUP_USE_XDG_DIRS true

# Rust
set -gx CARGO_INCREMENTAL 1
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
fish_add_path -a "$CARGO_HOME/bin"

# Go
set -gx GOPATH "$XDG_DATA_HOME/go"

# Python
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"

# Docker
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx MACHINE_STORAGE_PATH "$XDG_DATA_HOME/docker-machine"

# CLEANUP
set -gx HISTFILE "$XDG_STATE_HOME/bash/history"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -gx XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"
set -gx IPFS_PATH "$XDG_DATA_HOME/ipfs"
set -gx NOTMUCH_CONFIG "$XDG_CONFIG_HOME/notmuch-config"
set -gx KDEHOME "XDG_CONFIG_HOME/kde"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -gx INPUTRC "$XDG_CONFIG_HOME/shell/inputrc"
set -gx ALSA_CONFIG_PATH "$XDG_CONFIG_HOME/alsa/asoundrc"
set -gx WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
set -gx KODI_DATA "$XDG_DATA_HOME/kodi"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -gx ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible/ansible.cfg"
set -gx WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
set -gx MBSYNCRC "$XDG_CONFIG_HOME/mbsync/config"
set -gx ELECTRUMDIR "$XDG_DATA_HOME/electrum"

### Aliases
alias v=$EDITOR

alias cp="cp -riv"
alias mv="mv -iv"
alias ln="ln -iv"
alias rm="rm -riv"
alias trash="trash -v"
alias mkdir="mkdir -pv"
alias chmod="chmod -Rv"
alias chown="chown -Rv"

alias ls="exa"
alias ll="exa -la"
alias la="exa -a"
alias lt="exa -aT"
alias l.="exa -d .*"
alias df='df -h'
alias du='dust'
alias fd='fd --hidden'
alias rg='rg -.'
alias ag='ag -a'
alias cat="bat"
alias less="bat"
alias tree="tree -a"
alias top="btm"
alias htop="btm"
alias grep="rg"

alias fishrc="$EDITOR $XDG_CONFIG_HOME/fish/config.fish"
alias termrc="$EDITOR $XDG_CONFIG_HOME/foot/foot.ini"
alias swayrc="$EDITOR $XDG_CONFIG_HOME/sway/"
alias kanshirc="$EDITOR $XDG_CONFIG_HOME/kanshi/config"
alias barrc="$EDITOR $XDG_CONFIG_HOME/waybar/config"
alias vimrc="$EDITOR $XDG_CONFIG_HOME/nvim/"

alias su="su -s /bin/fish"
alias proc="ps aux | grep -v grep | grep "
alias inx="MOZ_ENABLE_WAYLAND=0 GDK_BACKEND=X11 QT_QPA_PLATFORM=xcb WINIT_UNIX_BACKEND=x11"
alias magit="swayhide emacsclient -c --eval '(magit-status-here)'"

alias mpv="swayhide mpv"
# use the word `command` to skip previous aliases
alias mpa="command mpv --no-video"
alias imv="swayhide imv"
alias zathura="swayhide zathura"

# Worktree-based-dotfiles storage
# alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'
function config --wraps='git'
    git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME $argv
end

# Vi bindings
function fish_user_key_bindings
    if test -n "$INSIDE_EMACS"
        fish_default_key_bindings
    else
        fish_vi_key_bindings
    end
end

thefuck --alias | source
