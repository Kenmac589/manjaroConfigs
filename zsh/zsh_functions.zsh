# My ZSH function list

# These f functions relate to varying use cases of fzf {{{

fnvg() {
    cd $HOME
    nvim $(fzf)
}

fql() {
    bat $(fzf)
}

fnt() {
    cwd=$PWD
    cd $HOME/Documents/MDNotes
    nvim $(fzf)
    cd $cwd
}

fnv() {
    nvim $(fzf --exact --layout reverse --preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window down)
}

fnvh() {
    nvim $(fzf --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' --exact --layout reverse --preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window down)
}

fimg() {
    imgcat $(fzf --exact --layout reverse --preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window down)
}

fall() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	open "$file"
}

fpdf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	open "$file"

}



p () {
    local open
    open=open   # on OSX, "open" opens a pdf in preview
    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | gtr " " "|");
            echo -e {1}"\n"{2} | ggrep -E "^|$v" -i --color=always;
        ' \
    | gcut -z -f 1 -d $'\t' | gtr -d '\n' | gxargs -r --null $open > /dev/null 2> /dev/null
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
install() {
    local token
    token=$(brew search --casks "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew install --cask $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew home $token
        fi
    fi
}

brewint() {
    local token
    token=$(brew search "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew home $token
        fi
    fi
}


# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
uninstall() {
    local token
    token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepae of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew uninstall --cask $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew home $token
        fi
    fi
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
    local inst=$(brew search "$1" | fzf -m)

    if [[ $inst ]]; then
        for prog in $(echo $inst);
        do; brew install $prog; done;
    fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# alternative using ripgrep-all (rga) combined with fzf-tmux preview
# This requires ripgrep-all (rga) installed: https://github.com/phiresky/ripgrep-all
# This implementation below makes use of "open" on macOS, which can be replaced by other commands if needed.
# allows to search in PDFs, E-Books, Office documents, zip, tar.gz, etc. (see https://github.com/phiresky/ripgrep-all)
# find-in-file - usage: fif <searchTerm> or fif "string with spaces" or fif "regex"
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" && echo "opening $file" && open "$file" || return 1;
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
fcf() {
  local file

  file="$(locate -i -0 $1 | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# fd - cd to selected directory
# fcd() {
#     local dir
#     dir=$(find ${1:-.} -path '*/\.*' -prune \
#                         -o -type d -print 2> /dev/null | fzf +m) &&
#     cd "$dir"
# }

# Switch files globally
fcd() {
    cd $HOME
    dir=$(fd -a -t d ${1:-.} | fzf +m)
    cd "$dir"
}

# Search downstream of local directory
fcl() {
    dir=$(fd -a -t d ${1:-.} | fzf +m)
    cd "$dir"
}

# Search Globally including hidden directories
fda() {
    cd $HOME
    dir=$(fd -a -H -t d ${1:-.} | fzf +m)
    cd "$dir"
}
# fda - including hidden directories
# fda() {
#   local dir
#   dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
# }

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-nvim} "$file"
  fi
}

# }}}

# Automations for folder organizing {{{

dwbib() {
    mv $HOME/Downloads/*.bib $HOME/Downloads/Citations
}

dwnbib() {
    mv $HOME/Downloads/*.nbib $HOME/Downloads/Citations
}

dwris() {
    mv $HOME/Downloads/*.ris $HOME/Downloads/Citations
}

dwpdf() {
    mv $HOME/Downloads/*.pdf $HOME/Downloads/pdfs
}

dwmp4() {
    mv $HOME/Downloads/*.mp4 $HOME/Downloads/vids
}


dwicns() {
    mv $HOME/Downloads/*.icns $HOME/Desktop/Other/Icon-Storage/
}

dwpro() {
    mv $HOME/Downloads/*.{py,java,html} $HOME/Downloads/Text_Files/Programs
}

dwdata() {
    mv $HOME/Downloads/*.{csv.xlsx} $HOME/Downloads/Text_Files/Programs/Data_Files
}

frdwn() {
    mv $HOME/Downloads/*${1}* ./
}
frdwnzp() {
    mv $HOME/Downloads/*${1}* ./
    for i in dir; do unzip '*.zip'; done
}

add() {
    mv ${file} ./
}

# }}}

# Academic Work {{{

apaodt() {
    pandoc -C -t odt --reference-doc=/Users/kenzie_mackinnon/.pandoc/templates/APA.odt ${1} -o ${2}
}

paperLib() {
    mv ${1} $HOME/Documents/Papers/
}

citeKey() {
    export BIBFILES="$(fd --follow --no-ignore -e bib)"
    if ! test "$BIBFILES"; then
        echo "No biblatex files" >&2
        exit 1
    fi

    cat $BIBFILES | grep '^@' |
        sed 's,^[^{]*{,,g' | sed 's/, *$//g' | sort -u |  # Get citekeys
        fzf -e -m -q "$(echo $@)" -1 \
            --inline-info --preview-window=up \
            --tabstop=4 --preview='CITEKEY={}
            PATTERN="@.*{$CITEKEY, *"
            grep -l "$PATTERN" $BIBFILES
            echo ------------------------------ | cut -c1-$COLUMNS
            echo
            grep -h -A 3 "$PATTERN" $BIBFILES' |
        sed "s/^/@/g" | sed "s/$/;/g" |         # Add separators
        tr "\n" " " |                           # Join lines
        rev | cut -c3- | rev            # Trim last separator
}

bib() {
    sh $HOME/scripts/biblo.sh | pbcopy;
}

bibgl() {
   sh $HOME/scripts/bib.sh;
}

# Not working
bibS() { sh $HOME/scripts/bibSearch.sh ${1} | pbcopy; }

bibg() { grep -i -n "${1}" ./*.bib }

# List Functions
bibKeyLs() { sh $HOME/scripts/listKeys.sh }
doiList() { sh $HOME/scripts/listDois.sh }

doi2bib() {
    echo >> /Users/kenzie_mackinnon/Documents/Papers/bib.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> $HOME/Documents/Papers/bib.bib;
    echo >> /Users/kenzie_mackinnon/Documents/Papers/bib.bib;
}

doi2lit() {
    echo >> /Users/kenzie_mackinnon/Documents/Papers/interestingLiterature.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> $HOME/Documents/Papers/interestingLiterature.bib;
    echo >> /Users/kenzie_mackinnon/Documents/Papers/interestingLiterature.bib;
    scihub -s ${1} -ow N -O $HOME/Documents/Papers
}

doi2litd() { cd $HOME/Documents/Papers/ }

doi() {
    # Add Paper to bibliography
    echo >> ./*.bib
    curl -s "http://api.crossref.org/works/${1}/transform/application/x-bibtex" >> ./*.bib
    echo >> ./*.bib
    # Fetch Paper from Scihub
    scihub -s "${1}" -O ./
}

# Fetch doi's from .bib file
doiFetch() {
    touch doiList.txt
    sh $HOME/scripts/listDois.sh | >> doiList.txt
   # rg --type-add 'bib:*.bib' -tbib "type= " >> doiList.txt
}

# Mass get papers from doiList
paper-dl() {
    doiFetch
    scihub -s doiList.txt -ow N
}

# Download bib input only
doid() {
    echo >> ${2}
    curl -s "http://api.crossref.org/works/${1}/transform/application/x-bibtex" >> ${2}
    echo >> ${2}
}

# Template for using zotero
panzotmd() {
    cp $HOME/Documents/pandoc/pandocZoteroMarkdown.md ./${1}.md
    nvim ${1}.md
}

# Add a paper to PapersGit Repository
paperGitadd() {
    cwd=$PWD
    mkdir $HOME/Documents/PapersGit/"Paper-${1}"
    mkdir $HOME/Documents/PapersGit/"Paper-${1}"/"${1}_Literature"
    ln $cwd/${1}.md $HOME/Documents/PapersGit/"Paper-${1}"/${1}.md
    ln $cwd/"${1}_Literature"/${1}.bib $HOME/Documents/PapersGit/"Paper-${1}"/"${1}_Literature"/${1}.bib
}

# Using a local bib file
panbibmd() {

    # Store the directory you are calling this
    cwd=$PWD
    mkdir ./${1}
    touch ./${1}/${1}.md
    touch ./${1}/${1}.bib

    # Filling Markdown Files with appropriate data
    echo -e "---" >> $cwd/${1}/${1}.md
    echo -e "title: '${1}'" >> $cwd/${1}/${1}.md
    echo -e "author: 'Kenzie MacKinnon'" >> $cwd/${1}/${1}.md
    echo -e "date: '$(date)'" >> $cwd/${1}/${1}.md
    echo -e "bibliography: '$cwd/${1}/${1}.bib'" >> $cwd/${1}/${1}.md
    echo -e "csl: '$HOME/.pandoc/styles/apa-7.csl'" >> $cwd/${1}/${1}.md
    echo -e "--- \n \n \n" >> $cwd/${1}/${1}.md
    echo -e "# References\n" >> $cwd/${1}/${1}.md
    echo -e ":::{#refs}" >> $cwd/${1}/${1}.md
    echo -e ":::" >> $cwd/${1}/${1}.md

    # Adding Papers to PapersGit Repository
    mkdir $HOME/Documents/PapersGit/"Paper-${1}"
    ln $cwd/${1}/${1}.md $HOME/Documents/PapersGit/"Paper-${1}"/${1}.md
    ln $cwd/${1}/${1}.bib $HOME/Documents/PapersGit/"Paper-${1}"/${1}.bib

    nvim ./${1}/${1}.md

}


# Organizing skim notes into a folder for the first time
skimOrgN() {
    mkdir skimNotes
    mv ./*.skim ./skimNotes
}

# Sending skim notes in current directory to current established folder
skimOrg() {
    mv ./*.skim ./skimNotes
}

# Opening all skim files on current directory in one window
skimall() {
    open *.skim
    # Next line useful for when skim is set to open files in separate windows
    osascript $HOME/scripts/mergeSkims.scpt
}

skimview() {
    open *.pdf
}

# Printout Skim File Content in the command line
# Not Currently Working
skimntview() {
    sh $HOME/scripts/skimNoteView.sh ${file}
}

drft() {
    sh $HOME/scripts/draft.sh
}

# }}}

# COVID-19 TUI Commands {{{

cov() {
    curl -L https://covid19-cli.wareneutron.com
}
covCAN() {
    curl -L https://covid19-cli.wareneutron.com/124
}
covDash() {
    curl -L https://covid19-cli.wareneutron.com/history/charts/ph
}

# }}}

# Various Utilities {{{

# Print man pages in PostScipt to auto open in Skim
manp() {
    man -t "${1}" | open -f -a Skim
}

# Automating bunkr downloader (Not sure if working)
bunkser(){
    rm /Volumes/Download2/Server_Drive/Mirror/Gallery/bunkr/URLs.txt
    touch /Volumes/Download2/Server_Drive/Mirror/Gallery/bunkr/URLs.txt
    echo "${1}" | tee -a /Volumes/Download2/Server_Drive/Mirror/Gallery/bunkr/URLs.txt
    sh /Volumes/Download2/Server_Drive/Mirror/Gallery/bunkr/Start.sh
}

# notSure() {
#     $(/Users/kenzie_mackinnon/go/bin/bibtex-ls)
# }

# Measuring Shell load time
timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Will change the file type extension of all files in current directory only
extChangeCd() {
    old_ext=$1
    new_ext=$2
    for file in *."$old_ext"; do mv "$file" "${file%.$old_ext}.$new_ext"; done
}

# Will change extension of files recursively
extChangeRec() {
    old_ext=$1
    new_ext=$2
    for file in **/*."$old_ext"; do mv "$file" "${file%.$old_ext}.$new_ext"; done
}

# Will open up all markdown files in current directory in neovim
nvmd(){
    nvim *.md
}

# Will open up all text files in current directory in neovim
nvtxt(){
    nvim *.txt
}

# Add Bookmark URL to Resources.md file
bmkadd() {
    echo >> $HOME/Desktop/Programming/Resources.md
    echo ${1} >> $HOME/Desktop/Programming/Resources.md
    echo ${2} >> $HOME/Desktop/Programming/Resources.md
    echo >> $HOME/Desktop/Programming/Resources.md
}

# # Coverts online recipes to something readable in CLI
# get_recipe() {
#     curl -sG "https://plainoldrecipe.com/recipe" -d "url=${1}" | pandoc -f html -t markdown
# }

gdl() {
    sh $HOME/scripts/urlTxtCache.sh
    echo ${1} >> url.txt
    gallery-dl ${1} 
}

# }}}

# Backing things up {{{

# Backing up configurations to network drive
driveSync() {
    cp -ivr $HOME/.config/ /Volumes/Download2/Server_Drive/file_copies
    cp -ivr $HOME/Documents/MDNotes /Volumes/Download2/Server_Drive/file_copies
}

iServerUpdate() {
    # Empty current last backup to allow previous one to be moved in
    # rm /Volumes/Download2/Server_Drive/iCloud_Backup/Last_Backup/*
    # Add immediately previous backup
    # mv /Volumes/Download2/Server_Drive/iCloud_Backup/* /Volumes/Download2/Server_Drive/iCloud_Backup/Last_Backup/
    # Copy iCloud Folder to Backup Folder
    cp -r ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/* /Volumes/Download2/Server_Drive/iCloud_Backup
    cp -r ~/Desktop /Volumes/Download2/Server_Drive/iCloud_Backup/
}

# Update file that keeps track of homebrew packages
backupBrewList() {
    rm $HOME/.config/brewlistCopy.txt
    touch $HOME/.config/brewlistCopy.txt
    echo -e "# Installed Packages \n" >> $HOME/.config/brewlistCopy.txt
    brew list >> $HOME/.config/brewlistCopy.txt
    echo "# Installed Casks \n" >> $HOME/.config/brewlistCopy.txt
    brew list --casks >> $HOME/.config/brewlistCopy.txt
}


# Update repositories with one command
Update() {
    # Store the directory you are calling this
    cwd=$PWD
    # Backup installed homebrew package list
    # backupBrewList # Relies on backupBrewList function
    # First my dotfiles
    cd $HOME/.config/
    git add . && git commit -m "Update" && git push
    # Then my scripts
    cd $HOME/scripts/
    git add . && git commit -m "Update" && git push
    # Updating PapersGit Repository
    cd $HOME/Documents/PapersGit/
    git add . && git commit -m "Update" && git push
    # Updating PapersGit Repository
    cd $HOME/Documents/MDNotes/
    git add . && git commit -m "Update" && git push
    # Go back to what ever directory that was ran from
    cd $cwd

}

sendit() {
    git add . && git commit -m "Update" && git push
}

# }}}

# Zsh Managing functions {{{

# Adding files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Sourcing key files
function zsh_source() {
    [ -f "$ZDOTDIR/$1.zsh" ] && source "$ZDOTDIR/$1.zsh"
}

# Set a theme
function zsh_set_theme() {
    [ -f "$ZDOTDIR/themes/$1.zsh" ] && source "$ZDOTDIR/themes/$1.zsh"
}

# Adding Plugins
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# Adding Themes
function zsh_add_theme() {
    THEME_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/themes/$THEME_NAME" ]; then
        # For plugins
        zsh_add_file "themes/$THEME_NAME/$THEME_NAME.plugin.zsh" || \
        zsh_add_file "themes/$THEME_NAME/$THEME_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/themes/$THEME_NAME"
    fi
}


function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}

# }}}

