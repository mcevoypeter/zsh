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

# Enable `git` tab-complete.
autoload -Uz compinit && compinit
