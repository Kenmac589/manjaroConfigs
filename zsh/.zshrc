########################################################
#  _  __              _             _____    _         #
# | |/ /___ _ __  ___(_) ___  ___  |__  /___| |__      #
# | ' // _ \ '_ \|_  / |/ _ \/ __|   / // __| '_ \     #
# | . \  __/ | | |/ /| |  __/\__ \  / /_\__ \ | | |    #
# |_|\_\___|_| |_/___|_|\___||___/ /____|___/_| |_|    #
#                                                      #
########################################################
# autoload -Uz compinit
# compinit
# Load function for time loading
zmodload zsh/zprof

# Sourcing files {{{
source $ZDOTDIR/zsh_functions.zsh
source $ZDOTDIR/zsh_aliases.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/zsh_exports.zsh
source $ZDOTDIR/zsh_theme.zsh

# }}}

# Plugins {{{

zsh_add_plugin "rupa/z"
zsh_add_plugin "davidde/git"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "wting/autojump"
zsh_add_plugin "ikhurramraza/bol"
zsh_add_plugin "hohmannr/bubblified"
zsh_add_plugin "gko/ssh-connect"
zsh_add_plugin "zpm-zsh/ls"
# zsh_add_plugin "zshzoo/omz-themes-standalone"

# Themes
# zsh_add_theme "eendroroy/nothing"
# zsh_add_theme "sahariko/neon"

# }}}

# Add completions {{{
# zsh_add_completion "esc/conda-zsh-completion"

# }}}

export BAT_THEME="Solarized (light)"

autoload -Uz promptinit
promptinit
prompt walters

# Some Export Paths
# export PATH=$HOME/bin:/opt/homebrew/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export ZSH="/Users/kenzie_mackinnon/.oh-my-zsh"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export $EDITOR='nvim'

# Fix cursor
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Fuzzy Finder Configurations {{{
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="fd -t d . $HOME/"
export FZF_ALT_C_COMMAND="fd -t d . ./"
export DISPLAY=:0

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --hidden --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi



# }}}

# Example aliases
alias myz="nvim ~/.config/zsh/zsh_aliases.zsh"
alias zfun="nvim ~/.config/zsh/zsh_functions.zsh"
# alias luamake="/Users/kenzie_mackinnon/scripts/lua-language-server/3rd/luamake/luamake"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# export ZPLUG_HOME=/opt/homebrew/opt/zplug
# source $ZPLUG_HOME/init.zsh
# if type brew &>/dev/null; then
#     FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# 
#     autoload -Uz compinit
#     compinit
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kenziemac/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kenziemac/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kenziemac/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kenziemac/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> conda initialize >>> {{{
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/kenzie_mackinnon/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/kenzie_mackinnon/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/kenzie_mackinnon/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/kenzie_mackinnon/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# <<< conda initialize <<< }}}

# export $HOME/.config/vim/plugged/fzf/shell/completion.zsh
# export $HOME/.config/vim/plugged/fzf/shell/completion.zsh.zsh
# The following lines were added by compinstall
alias idea="eureka"
