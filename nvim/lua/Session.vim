let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim/lua
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/.config/nvim/init.vim
edit ~/.config/nvim/lua/pluginConfigs.lua
argglobal
balt ~/.config/nvim/lua/paqPlugins.lua
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
382
normal! zo
let s:l = 423 - ((39 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 423
normal! 0
tabnext 1
badd +591 ~/.config/nvim/init.vim
badd +51 ~/.config/nvim/plugs.vim
badd +1 ~/.config/cobib/config.py
badd +423 ~/.config/nvim/lua/pluginConfigs.lua
badd +1 ~/scripts/skimTextConvesion.sh
badd +1 ~/scripts/skimNoteView.sh
badd +12 ~/Documents/MDNotes/src/note-2022-02-17.md
badd +1 ~/.config/zsh/.zshrc
badd +1 ~/.config/zsh/my_zsh_functions.zsh
badd +1 ~/.config/nvim/lua/paqPlugins.lua
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
