shopt -s extglob
shopt -s nocaseglob
shopt -s autocd
set bell-style none

export DISPLAY=:0
export TERM=xterm-256color
export EDITOR=vim
export LIBGL_ALWAYS_INDIRECT=1

#Add my scripts to path
bind TAB:menu-complete
bind '"^[[Z":menu-complete-backward'
export PATH=$PATH:"~/.bashScripts/:~/.local/bin"
export FIGNORE=".dll:.DLL"
complete -E

#Use vi mode for bash
#set -o vi
set -o emacs

#Set up better dircolors for ls --color
eval "$(dircolors ~/.dircolors)"

#Detect WSL or Git-Bash
function _is_wsl() {
    uname="$(uname -a)"
    if [[ "$uname" =~ Microsoft ]]; then
        echo "WSL"
    fi
}

#Set up powerline
function _update_ps1() {
    if [[ $(_is_wsl) = "WSL" ]]; then
        PS1=$(powerline-shell $?)
        echo -ne "\e]0;WSL - $PWD\a"
    fi
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#Sourcing additional bash scripts
source ~/.bashScripts/acd_func.sh
source ~/.bashScripts/z.sh


# Git branch bash completion
if [ -f ~/.bashScripts/git-completion.bash ]; then
  . ~/.bashScripts/git-completion.bash

  # Add git completion to aliases
  __git_complete g    __git_main
  __git_complete gl   _git_log
  __git_complete gm   __git_merge
  __git_complete gb   _git_branch
  __git_complete gbd  _git_branch
  __git_complete gbD  _git_branch
  __git_complete gpdb _git_branch

  __git_complete gco  _git_checkout
  __git_complete gct  _git_checkout
fi

#if [ -t 1 ]; then
#    cd ~
#fi

# FZF completion for git things
bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

# FZF for lyfe
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Bring in my common aliases
[ -f ~/.aliases.sh ] && source ~/.aliases.sh
