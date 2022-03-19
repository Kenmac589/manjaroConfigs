let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd init.vim
tabnew
tabnew
tabnew
tabnew
tabnew
tabnew
tabrewind
edit ~/scripts/biblo.sh
argglobal
balt ~/scripts/nvim/plugs.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/scripts/listKeys.sh
argglobal
balt ~/scripts/listKeys.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/scripts/listDois.sh
argglobal
balt ~/scripts/listDois.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/.config/skimNoteView.sh
argglobal
balt ~/.config/zsh/zsh_aliases.zsh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit init.vim
argglobal
balt ~/.config/zsh/zsh_aliases.zsh
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 617 - ((616 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 617
normal! 0
tabnext
edit ~/.config/skimTextConvesion.sh
argglobal
balt ~/scripts/testAwk.awk
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/scripts/listDois.sh
argglobal
balt ~/scripts/listKeys.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 7
badd +152 init.vim
badd +17 plugs.vim
badd +1 ~/scripts/listKeys.sh
badd +1 ~/scripts/listDois.sh
badd +1 ~/.config/skimNoteView.sh
badd +1 ~/.config/skimTextConvesion.sh
badd +1 ~/scripts/biblo.sh
badd +1 ~/scripts/nvim/plugs.vim
badd +1 ~/.config/zsh/zsh_aliases.zsh
badd +1 ~/scripts/testAwk.awk
badd +4 ~/.config/zsh/zsh-exports.zsh
badd +1 ~/.config/zsh/.zshrc
badd +328 ~/.config/zsh/zsh_functions.zsh
badd +1 ~/.config/cobib/config.py
badd +4 ~/scripts/testAwk.sh
badd +1 ~/.config/zsh/zsh-prompt.zsh
badd +1 ~/.config/wtf/config.yml
badd +1 ~/scripts/rfv.sh
badd +1 ~/scripts/.gitignore
badd +1 ~/scripts/nvim/lua/pluginConfigs.lua
badd +10 ~/scripts/rfvtxt.sh
badd +1 lua/pluginConfigs.lua
badd +1 ~/.config/fnt.sh
badd +1 ~/.config/.gitignore
badd +1 ~/.config/rfv.sh
badd +1 /Volumes/Download2/Server_Drive/file_copies/.zprofile
badd +1 ~/.config/zsh/my_zsh_functions.zsh
badd +1 lua/paqPlugins.lua
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
