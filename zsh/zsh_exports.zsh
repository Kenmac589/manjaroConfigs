#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# export PATH=$HOME/bin:/opt/homebrew/bin:$PATH
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/bin:$PATH"
# export PATH="/opt/homebrew/bin:$PATH"
# export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
# export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
# export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
# export GOROOT="/opt/homebrew/bin/go:$PATH"
# export GOPATH="/Users/kenzie_mackinnon/go"
# export RUSTUP_HOME="/Users/kenzie_mackinnon/.rustup:$PATH"

export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.fnm:$PATH
export PATH="$PATH:./node_modules/.bin"
eval "$(fnm env)"
# eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"

# >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
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
# # <<< conda initialize <<<
