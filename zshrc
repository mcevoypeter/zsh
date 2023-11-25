#
# FUNCTIONS
#

function fzf_cmd() {
  fzf --multi "$@"
}

# Select one or more commands from the shell's history.
function zle_history() {
  local cmd=$(history 1                                                        \
    | fzf_cmd --no-sort --scheme=history --tac                                 \
    | awk '!($1="")' ORS=' &&'                                                 \
    | sed 's|^ *||'                                                            \
    | sed 's|&&$||')
  [[ -n "$cmd" ]] && zle -U "$cmd"
}

# Select one or more file system entries relative to $HOME.
function zle_ls() {
  fzf_preview="[ -d {} ]                                                       \
    && exa --all --long {}                                                     \
    || bat --color=always --line-range=0:200 {} --style=numbers"
  local entry=$(fd . / --hidden --no-ignore-vcs                                \
    | fzf_cmd --preview="$fzf_preview" --scheme=path                           \
    | awk 1 ORS=' ')
  [[ -n "$entry" ]] && zle -U "$entry"
}

# Select one or more PIDs from procs.
function zle_ps() {
  local pid=$(procs                                                            \
    | fzf_cmd --header-lines=2 --no-sort --tac                                 \
    | awk '{print $1}' ORS=' ')
  [[ -n "$pid" ]] && zle -U "$pid"
}

#
# COMMAND LINE PROMPT
#

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
local git_branch='(%F{red}%b%f)'
zstyle ':vcs_info:git:*' formats ${git_branch}
zstyle ':vcs_info:*' enable git
setopt prompt_subst
local user='%B%n%b'
local host='%B%F{magenta}%m%f%b'
local dir='%B%F{cyan}%3~%f%b'
PROMPT='${user}@${host}:${dir} $vcs_info_msg_0_
%(?.%F{green}.%F{red})%#%f '
RPROMPT=

#
# HISTORY
#

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

# see https://unix.stackexchange.com/a/273863
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#
# LINE EDITOR
#

# Turn on vi mode.
bindkey -v
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M viins '' edit-command-line
bindkey -M vicmd '' edit-command-line

# tab complete
bindkey -M viins '\t' expand-or-complete

# , ^E to move to beginning, end of line, respectively.
bindkey -M viins '' beginning-of-line
bindkey -M viins '' end-of-line

# , ^U to delete word, line, respectively.
bindkey -M viins '' backward-kill-word
bindkey -M viins '' kill-whole-line

# Enable backspace after returning from command mode.
bindkey -M viins '' backward-delete-char
bindkey -M viins '' backward-delete-char

# Access command history.
zle -N zle_history
bindkey -M viins '^R' zle_history

# Access files and directories.
zle -N zle_ls
bindkey -M viins '^F' zle_ls

# Access process table.
zle -N zle_ps
bindkey -M viins '^G' zle_ps

# Enable `git` tab-complete.
autoload -Uz compinit && compinit

eval "$(direnv hook zsh)"
eval "$(pyenv init -)"

# Must be run last.
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
