########################################################
#  _  __              _             _____    _         #
# | |/ /___ _ __  ___(_) ___  ___  |__  /___| |__      #
# | ' // _ \ '_ \|_  / |/ _ \/ __|   / // __| '_ \     #
# | . \  __/ | | |/ /| |  __/\__ \  / /_\__ \ | | |    #
# |_|\_\___|_| |_/___|_|\___||___/ /____|___/_| |_|    #
#                                                      #
########################################################

# Kenzie's extra zsh configuration file

# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr

# Fixing some dangerous commands
alias mv="mv -iv"
alias cp="cp -riv"
alias rm="rm -i"
alias mkdir="mkdir -vp"
alias rmd="rm -d"
alias exah="exa -lh"

# Upgrading Default Ones to Alternative Versions {{{

# alias man="batman"

# }}}

# Shortening terminal commands {{{

alias py="python"
alias nv="nvim"
alias ytdl="youtube-dl"
alias c="clear"
alias neo="neofetch"
alias tk="task"
alias wg="wget"
alias sc="scrape -n -all -i"
alias pdc="pandoc"
alias sci="scidownl -D"
alias zt ="zathura"
alias doc="docx2txt"
alias wtf="wtfutil"
alias gfd="gofile-dl"
alias ptable="periodic_table_tui"
alias yget="you-get"
alias ofet="onefetch"
alias panmat="pandocomatic"
alias ..="cd .."
alias tx="tmux"
alias webt="webtorrent"
alias ran="ranger"

# }}}

# Full commands {{{

alias vscoup="cd /Volumes/Download2/Server_Drive/Mirror/Gallery && gallery-dl -i /Users/kenzie_mackinnon/Documents/Admin_Files/vsco_links.md"
alias vscodl="gallery-dl -i /Users/kenzie_mackinnon/Documents/Admin_Files/vsco_links.md"
alias reddup="gallery-dl -i /Users/kenzie_mackinnon/Documents/Admin_files/reddit_links.md"
alias uzpall="for i in dir; do unzip '*.zip'; done"
alias rmzip="for i in dir; do \rm *.zip; done"
alias lazyg="git add . && git commit -m "update" && git push"
alias pcp="pwd|pbcopy"
alias o="xdg-open"
alias b='buku --suggest'
alias jpynt="jupyter notebook"
alias jpyqt="jupyter qtconsole &"
alias nvs="nvim -S"
alias soz="exec zsh"
alias lv="/Users/kenzie_mackinnon/.local/bin/lvim"
alias nvcon="nvim -S ~/.config/nvim/nvim_full_configs.vim"
alias fe="fzf -e"
alias cf="cd ~/.config"
alias duck="w3m https://duckduckgo.com/"
alias dwn="cd ~/Downloads/ && clear"
alias tsl="task list"
alias tmk="tmux kill-session"
alias tkl="task list && task calendar"
alias tka="task add"
alias tmxco="nvim ~/.tmux.conf"
alias tmxso="tmux source ~/.tmux.conf"
alias tmxfo="cd $HOME/.config/tmux/"
alias jsync="jupytext --sync"
alias bws="bw list items --search"
alias ni="nix-env -iA"
alias app"cd /Applications && open"
alias ptest="python ~/Desktop/Progamming/Python_Related/commandLineInputDemo.py"
alias stest="speedtest-cli --secure"
alias mpvl="mpv --loop-file=inf"
alias apaodtz="pandoc -t odt --reference-doc=/Users/kenzie_mackinnon/.pandoc/templates/APA.odt -L pandoc-zotxt.lua -C"
# alias apaodt="pandoc -C -t odt --reference-doc=/Users/kenzie_mackinnon/.pandoc/templates/APA.odt"
alias nas="ssh kmac589@192.168.1.219"
alias jelly="ssh jellyfin@192.168.1.219"
alias bibSearch="sh $HOME/scripts/bibSearch.sh"
alias isbnbib="sh $HOME/scripts/isbnbib.sh"
alias lst="ls -t -r"
alias wordle="sh $HOME/scripts/wordle.sh"
# alias rg="sh $HOME/scripts/rfv.sh"
alias fmd="sh $HOME/scripts/rfvmd.sh"
alias ftxt="sh $HOME/scripts/rfvtxt.sh"
alias fty="sh $HOME/scripts/rfvFileType.sh"
alias btgp="batgrep -S --context=2 --hidden"
alias lsz="l -S -r"
alias bioc="python $HOME/Documents/Year_5_Winter/BIOC-2300/biochemScripts/equationTool.py"
alias UNS="nvim $HOME/Desktop/Work/UNS/Academic_Advisor/Academic_Advising_Info.md"
alias covid="curl -L https://covid19-cli.wareneutron.com"
alias ymdl="ytmdl -o=/Users/kenzie_mackinnon/Music/ytmdl"
alias diskl="diskutil list"
alias stopw='pdd -s "1"'
alias karabiner="/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
alias txls="tmux list-sessions"
alias mbssh="ssh kenzie_mackinnon@kenziesm1mbp13"
alias cpip="/home/kenziemac/anaconda3/bin/python -m pip install”

# }}}

# Navigation Shortcuts {{{

alias vmrc="cd /Users/kenzie_mackinnon/.vim_runtime/vimrcs/"
alias sch="cd /Users/kenzie_mackinnon/Desktop/Year_5_Fall/"
alias csci="cd /Users/kenzie_mackinnon/Desktop/Year_5_Fall/CSCI-2202"
alias srv="cd /Volumes/Download2/Server_Drive/"
alias srvd="cd /Volumes/Download2/Server_Drive/Mirror/Gallery"
alias srvco="cd /Volumes/Download2/Server_Drive/Code"
alias vold="cd /Volumes/Server_Drive/Download2/Server_Drive/Mirror/Gallery"
alias vol="cd /Volumes/LaCie/Server_Drive/Mirror/Gallery"
alias qn="sh /Users/kenzie_mackinnon/scripts/quicknote.sh"
alias nvfo="cd ~/.config/nvim/"
alias de="cd ~/Desktop/"
alias ubscr="cd /Users/kenzie_mackinnon/Library/Application\ Support/Übersicht/widgets"
alias scri="cd $HOME/scripts"
alias nts="cd $HOME/Documents/MDNotes/"
alias icons="cd $HOME/Desktop/Other/Icon-Storage/"
alias icloud="cd /Users/kenzie_mackinnon/Library/Mobile\ Documents/com~apple~CloudDocs"
alias zdir="cd $HOME/.config/zsh"
alias ~="cd $HOME/"

# }}}

# Opening files {{{

alias zrc="nvim ~/.config/zsh/.zshrc"
alias nvrc="nvim ~/.config/nvim/init.vim"
alias nvpl="nvim ~/.config/nvim/plugs.vim"
alias neoc="nvim ~/.config/neofetch/config.conf"
alias stc="nvim $HOME/Desktop/Work/MDNotes/stickyNote.md"
alias hypcon="nvim $HOME/.hyper.js"
alias gitig="nvim ./.gitignore"
alias conTheme="nvim $ZDOTDIR/zsh_theme.zsh"

# }}}

# Shell Scripts {{{

alias bthff="sh /Users/kenzie_mackinnon/scripts/batch_convert.sh"
alias dlorg="sh /Users/kenzie_mackinnon/scripts/Download_Organizing.sh"
alias git-sum="~/scripts/git-summary"
alias skimtxt="sh $HOME/scripts/skimTextConvesion.sh"
alias rates="$HOME/GitHub_Projects/rates-0.6.0-x86_64-apple-darwin/rates"
alias qlock="$HOME/scripts/qlock"
alias skimsyncable="$HOME/scripts/skimsyncable.sh"
alias fsw="$HOME/scripts/fsw"

# }}}

# Silly Commands {{{

alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias weather="curl http://wttr.in/"
alias starwars="nc towel.blinkenlights.nl 23"
alias aqua="asciiquarium"

# }}}

# Zsh Scripts {{{


# Working with nvim-ipy

init_python3_pipenv () {
   echo "Setting up pipenv environment"
   pipenv install --three
   echo "Installing ipython kernel"
   pipenv install --dev ipykernel
   # get name of environment and remove checksum for pretty name
   venv_name=$(basename -- $(pipenv --venv))
   venv_prettyname=$(echo $venv_name | cut -d '-' -f 1)
   echo "Adding ipython kernel to list of jupyter kernels"
   $(pipenv --py) -m ipykernel install --user --name $venv_name \
   --display-name "Python3 ($venv_prettyname)"
}

## Related to fzf

# }}}

# Making things work between linux and mac better {{{
alias pbcopy="xclip -sel clip"



# }}}

# Changing/making/removing directory
# setopt auto_pushd
# setopt pushd_ignore_dups
# setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# function d () {
#     if [[ -n $1 ]]; then
#         dirs "$@"
#     else
#         dirs -v | head -n 10
#     fi
# }
# 
# compdef _dirs d

# List directory contents
alias lsa='ls -lah'
# alias l='ls -lah'
# alias ll='ls -lh'
# alias la='ls -lAh'

