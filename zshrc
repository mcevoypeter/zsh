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
