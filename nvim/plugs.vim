""""""""""""""""""""""""""""""""""""""""""""""""""""
"  __  __         ____  _             _
" |  \/  |_   _  |  _ \| |_   _  __ _(_)_ __  ___
" | |\/| | | | | | |_) | | | | |/ _` | | '_ \/ __|
" | |  | | |_| | |  __/| | |_| | (_| | | | | \__ \
" |_|  |_|\__, | |_|   |_|\__,_|\__, |_|_| |_|___/
"          |___/                 |___/
"
""""""""""""""""""""""""""""""""""""""""""""""""""""


" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Language Server Protocol for Neovim
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Debugger for Neovim
Plug 'mfussenegger/nvim-dap'

" Language Parser
" We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plugins related to nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" File Browsers
Plug 'scrooloose/nerdtree'
"Plug 'ms-jpq/chadtree'

Plug 'ryanoasis/vim-devicons'

Plug 'christoomey/vim-tmux-navigator'

" AutoSave files on a exit of insert mode
Plug '907th/vim-auto-save'

" Completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'f3fora/cmp-spell'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Lua Based Window Features
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
"Plug 'kdheepak/tabline.nvim'

" iA Writer like focus on line
Plug 'junegunn/limelight.vim'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'chengzeyi/fzf-preview.vim'

Plug 'wesQ3/vim-windowswap'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'myusuf3/numbers.vim'

" main one
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc

" Related to Markdown Support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Distraction free writing in vim
Plug 'junegunn/goyo.vim'

" Language server for linked notes
" Plug 'mickael-menu/zk-nvim'

" Themes used in vim
Plug 'arcticicestudio/nord-vim'
Plug 'rafalbromirski/vim-aurora'
Plug 'artanikin/vim-synthwave84'
Plug 'TroyFletcher/vim-colors-synthwave'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'glepnir/oceanic-material'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'hzchirs/vim-material'
Plug 'davidbachmann/vim-punk-colorscheme'
Plug 'mhartington/oceanic-next'

" CSV handling
Plug 'chrisbra/csv.vim'

" LatexSupport
Plug 'lervag/vimtex'

" iA Writer inspired theme
Plug 'logico-dev/typewriter'

" Python tools for Vim
Plug 'reconquest/vim-pythonx'

" Jupyter Support
Plug 'ivanov/vim-ipython'
Plug 'bfredl/nvim-ipy' " iPython Support for neovim
Plug 'untitled-ai/jupyter_ascending'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'GCBallesteros/vim-textobj-hydrogen'
Plug 'GCBallesteros/jupytext.vim'
" Plug 'ahmedkhalf/jupyter-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" Writing tools for Vim
Plug 'reedes/vim-pencil'

" Surrounding things
Plug 'tpope/vim-surround'

" Making search highlighting more tolerable
Plug 'romainl/vim-cool'

" Markdown-preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Evaluating code block inside markdown
Plug 'jubnzv/mdeval.nvim'

Plug 'amix/vim-zenroom2'
" Support for Java
Plug 'mfussenegger/nvim-jdtls'

" Automated Vim session
Plug 'thaerkh/vim-workspace'

" z for Vim
Plug 'rupa/v'

" Tasks manager
Plug 'tools-life/taskwiki'
" Plug 'blindFS/Vim-taskwarrior'

" Image Paste in Markdown
Plug 'ferrine/md-img-paste.vim'

" Vim Scripts
Plug 'inkarkat/vim-SyntaxRange'

" Library of Common Functions
Plug 'vim-scripts/ingo-library'

" Vim based slideshow presentations
Plug 'ingydotnet/vroom-pm'

" Presntation Slides
Plug 'dmbrownlee/vim-slides'

" Cite as you write
Plug 'GCBallesteros/vim-autocite'

" Presentation tool
Plug 'sotte/presenting.vim'

" Presentation tool
Plug 'sotte/presenting.vim'

" Co-pilot
" Plug 'github/copilot.vim'

" Makes fuzzy finder go to root directory
Plug 'airblade/vim-rooter'

" The almighty CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Send to window
Plug 'karoliskoncevicius/vim-sendtowindow'

" Language Support for R
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" Nvim Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Bullet List
Plug 'dkarter/bullets.vim'

" Personal Wiki for vim
Plug 'vimwiki/vimwiki'


" Skim Plugin
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }

" Themes used in vim ==> {{{

Plug 'arcticicestudio/nord-vim'
Plug 'rafalbromirski/vim-aurora'
Plug 'artanikin/vim-synthwave84'
Plug 'TroyFletcher/vim-colors-synthwave'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'glepnir/oceanic-material'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'hzchirs/vim-material'
Plug 'davidbachmann/vim-punk-colorscheme'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'

" }}}

" Currently Not in use ==> {{{

" Plug 'jupyter-vim/jupyter-vim'

Plug 'ahmedkhalf/jupyter-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'anufrievroman/vim-angry-reviewer'


" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'

" Plug 'sillybun/vim-repl' " Interactive Window when coding
" Plug 'hkupty/iron.nvim'

" Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

" Pandoc with Markdown
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" Personal Wiki for vim
" Plug 'vimwiki/vimwiki'

" }}}

call plug#end()
