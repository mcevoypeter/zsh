export BAT_THEME="Monokai Extended"
export EDITOR=$(which nvim)
export FZF_DEFAULT_COMMAND="fd --hidden --no-ignore"
export FZF_DEFAULT_OPTS="--cycle --keep-right --multi"
export GIT_AUTHOR_EMAIL="git@mcevoypeter.com"
export GIT_AUTHOR_NAME="Peter McEvoy"
export GIT_COMMITTER_EMAIL="git@mcevoypeter.com"
export GIT_COMMITTER_NAME="Peter McEvoy"
export GNUPGHOME="$HOME/.gnupg/trezor"
export GOBIN="$(go env GOBIN)"
export GOPATH="$(go env GOPATH)"
# Increase speed of key timeouts.
export KEYTIMEOUT=1

# from https://github.com/nvm-sh/nvm#git-install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PYENV_ROOT="$HOME/.pyenv"
# see https://forums.ankiweb.net/t/anki-doesnt-start-under-wayland-linux/10409
export QT_QPA_PLATFORM=xcb
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export TERM="tmux-256color"
export XDG_CURRENT_DESKTOP="sway"
