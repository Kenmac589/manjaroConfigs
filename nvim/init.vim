""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _  __              _             ___       _ _    "
" | |/ /___ _ __  ___(_) ___  ___  |_ _|_ __ (_) |_  "
" | ' // _ \ '_ \|_  / |/ _ \/ __|  | || '_ \| | __| "
" | . \  __/ | | |/ /| |  __/\__ \  | || | | | | |_  "
" |_|\_\___|_| |_/___|_|\___||___/ |___|_| |_|_|\__| "
"                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sourcing ===> {{{


" source ~/.config/nvim/plcon.vim
source $HOME/.config/nvim/macos.vim
source $HOME/.config/nvim/plugs.vim
source $HOME/.config/nvim/lsp-config.vim
luafile $HOME/.config/nvim/lua/pluginConfigs.lua
luafile $HOME/.config/nvim/lua/paqPlugins.lua

" }}}

" General Config ===> {{{

set nocompatible
filetype plugin on

" filetype off
set encoding=utf-8


" Appearance
syntax enable
if (has('termguicolors'))
  set termguicolors
endif


highlight Normal guibg=none
highlight NonText guibg=none

set background=dark
colorscheme kanagawa

" Editor Preferences

set number relativenumber
set cursorline
set autochdir
set scrolloff=3
set tabstop=4
set shiftwidth=4
set shell=zsh
set path+=**
set linebreak
set noswapfile
set wrap
set hidden

" Indent and tab rules

" Using expand tabs instead of characters
set expandtab

set autoindent smartindent

" Copy previous indentation on auto indent
set copyindent

set smarttab

" Searching rules
set incsearch
" set foldcolumn=1

" Ignore case when searching
set ignorecase
set smartcase

" Copy previous indentation on auto indent
set copyindent

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enabling mouse click for nvim
set mouse=a

" Don't redraw while executing macros (good performance config)
" set lazyredraw

" Setting how new windows open
set splitbelow splitright

" Start scrolling n chars before end of screen.
set sidescrolloff=7

" The minimal number of columns to scroll horizontaly
set sidescroll=1

autocmd InsertEnter * norm zz


" }}}

" Key Mappings ===> {{{

" Key Mappings and Plug Config
let mapleader = '\'

" Folder management
" nmap <F10> :foldopen<CR>
" nmap <F9> :foldclose<CR>

nnoremap <leader>\ :nohlsearch<CR>
nnoremap <leader>o :source /Users/kenzie_mackinnon/.config/nvim/init.vim<CR>


" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Press the space bar to type the : character in command mode.
nnoremap <space> :

nmap j gj
nmap k gk

" Navigating Buffers Like Tabs
nmap gb :bnext<CR>
nmap gB :bprevious<CR>

nnoremap <leader>bd :bdelete<CR>

" Insert a line below in normal mode
nmap oo o<Esc>k

" Insert a line above in normal mode
nmap OO O<Esc>j

"save the session, save modified files, and exit
command! Xs :mks! | :xa

" For Making pairs
inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

nnoremap <leader>nn :set number relativenumber<CR>
nnoremap <leader>NN :set nonumber norelativenumber<CR>
" inoremap \- <CR><backspace><backspace><tab>-<right><space>
nnoremap <leader>tt :tabclose<CR>


" }}}

" Functions ===> {{{

" Opening the URL Under
" function! OpenURLUnderCursor()
"     let s:uri = expand('<cWORD>')
"     let s:uri = substitute(s:uri, '?', '\\?', '')
"     let s:uri = shellescape(s:uri, 1)
" 	if s:uri != ''
" 	    silent exec "!open '".s:uri."'"
"         :redraw!
"     endif
" endfunction

" }}}

autocmd FileType tex,latex,markdown setlocal spell spelllang=en_ca

" File Configurations ===> {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldcolumn=0
augroup END

augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=marker
augroup END

augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal foldmethod=marker
    autocmd FileType lua setlocal tabstop=2 shiftwidth=2
augroup END

" Markdown {{{2

" Folding Scheme for Markdown {{{3
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction
" }}}

au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown set wrap
    autocmd FileType markdown set linebreak
    autocmd FileType markdown set breakindent
    autocmd FileType markdown setlocal foldmethod=marker
    autocmd FileType markdown nnoremap <Tab> >><CR>
    autocmd FileType markdown nnoremap <S-Tab> <<<CR>
    autocmd FileType markdown inoremap @, {{c1::}}<left><left>
augroup END

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

augroup filetype_text
    autocmd!
    autocmd FileType text inoremap @, {{c1::}}<left><left>
augroup END

" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'

" }}}

" ZSH {{{2

augroup filetype_zsh
    autocmd!
    autocmd FileType zsh setlocal foldmethod=marker
augroup END


" }}}

" Jupyter {{{2

if has('nvim')
    let g:python3_host_prog = '/home/kenziemac/anaconda3/bin/python'
else
    set pyxversion=3

    " OSX
    set pythonthreedll=/Users/kenzie_mackinnon/opt/anaconda3/bin/python

endif

" }}}

" Language Servers
set completeopt=menu,menuone,noselect
let g:limelight_conceal_ctermfg = "true"
" }}}

" Plugin Configurations ===> {{{

" Journalling
let g:journals_directory = "/Users/kenzie_mackinnon/Documents/journal"

" Toggling Transparent
nnoremap <leader>tr :TransparentToggle<CR>
let g:transparent_enabled = v:true

" Jupyter-Vim ==> {{{2

" Run current file
""nnoremap <buffer> <silent> <localleader>R :JupyterRunFile<CR>
""nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>
""
""" Change to directory of current file
""nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>
""
""" Send a selection of lines
""nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
""nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
""nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
""vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual
""
""nnoremap <buffer> <silent> <localleader>U :JupyterUpdateShell<CR>
""
""" Debugging maps
""nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>

" }}}

" Magma Config for Jupyter Notebooks
" nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
" nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
" xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
" nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
" nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
" nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>
"
" let g:magma_automatically_open_output = v:false

" Powerline configurations
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" Autosave
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events =  ["InsertLeave", "TextChanged"]


" NERDTREE
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=30
nnoremap <leader>v <cmd>NERDTreeToggle<CR>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<CR>


"command! -bang -nargs=? -complete=dir Files call fzf#vim#files($HOME)
command! -bang AllFiles call fzf#vim#files($HOME, <bang>0)
" Fuzy Finder
nnoremap <leader>f :Files<CR>
nnoremap <leader>fg :AllFiles<CR>
nnoremap <leader>fgt :GFiles <CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>rb :Lines<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ft <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>


let g:fzf_buffers_jump = 1
let g:fzf_preview_window = 'down:50%'
let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.6  }  }

" The Silver Searcher
" nnoremap <leader>s :Ag<CR>

" Ripgrep

nnoremap <leader>s :Rg<CR>

" coq_nvim
"let g:coq_settings = { 'auto_start': 'shut-up' }


" Vim-Markdown {{{2

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 1
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 1
" let g:vim_markdown_new_list_item_indent = 4
" let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_fenced_languages = ['python', '{code-block} ipython3=python', 'java', 'javascript', 'json=javascript', 'c', 'cpp']
" let g:mkdp_echo_preview_url = 0
let g:mkdp_markdown_css = '~/Documents/style.css'
let g:mkdp_highlight_css = '~/Documents/core.css'

" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1
" }}}

" Markdown Preview Related {{{2

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" defalt: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
let g:disable_sync_scroll = 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" }}}

" Numbers config
let g:numbers_exclude = ['goyo_pad']

" Goyo Config {{{2
nnoremap <silent> <leader>z :Goyo<cr>

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set nonumber norelativenumber
  set scrolloff=999
"  augroup goyoEnter
"    autocmd!
"    autocmd Limelight
"  augroup END
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  set number relativenumber

  " augroup goyoLeave
  "   autocmd!
  "   autocmd Limelight!
  " augroup END

  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width=80
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
let g:goyo_linenr = 1
nmap <F12> :Goyo <bar> Limelight!!<CR>"
nnoremap <silent> <leader>z :Goyo<cr>

  " Activate FOCUS mode with F12
  nmap <F12> :Goyo <bar> Limelight!!<CR>"


  " Change the cursor from block to i-beam in INSERT mode
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"
  " augroup myCmds
  "   au!
  "   autocmd VimEnter * silent !echo -ne "\e[1 q"
  " augroup END

" }}}
" Configuration for AngryReviewer
let g:AngryReviewerEnglish = 'american'
nnoremap <leader>ar :AngryReviewer<cr>
" Fzfbibtex
let $FZF_BIBTEX_CACHEDIR = '/Users/kenzie_mackinnon/Documents/fzfbib'
let $FZF_BIBTEX_SOURCES = '/Users/kenzie_mackinnon/Documents/fzfbib/masterLib/master.bib'

function! s:bibtex_cite_sink(lines)
    let r=system("bibtex-cite ", a:lines)
    execute ':normal! a' . r
endfunction

function! s:bibtex_markdown_sink(lines)
    let r=system("bibtex-markdown ", a:lines)
    execute ':normal! a' . r
endfunction


nnoremap <silent> <leader>c :call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_cite_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>

nnoremap <silent> <leader>m :call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_markdown_sink'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Markdown> "'})<CR>

function! s:bibtex_cite_sink_insert(lines)
    let r=system("bibtex-cite ", a:lines)
    execute ':normal! a' . r
    call feedkeys('a', 'n')
endfunction

inoremap <silent> @@ <c-g>u<c-o>:call fzf#run({
                        \ 'source': 'bibtex-ls',
                        \ 'sink*': function('<sid>bibtex_cite_sink_insert'),
                        \ 'up': '40%',
                        \ 'options': '--ansi --layout=reverse-list --multi --prompt "Cite> "'})<CR>

" Vim autocite configuration
let g:autocite_search_in_dir=1
let g:autocute_search_in_doc=1


" }}}

" Nabla
nnoremap <F5> :lua require("nabla").action()<CR>
nnoremap <leader>p :lua require("nabla").popup()<CR> 

" Customize with popup({border = ...})  : `single` (default), `double`, `rounded`

" Vim Material Config {{{

let g:material_theme_style = 'default'
let g:material_terminal_italics = 1

let g:rg_command='rg %s --files --hidden --color=never --glob ""'
" }}}


" vim: set foldmethod=marker foldlevel=0;
