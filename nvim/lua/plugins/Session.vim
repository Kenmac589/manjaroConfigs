let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim/lua/plugins
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/.config/nvim/init.vim
edit ~/.config/nvim/plugs.vim
argglobal
balt ~/.config/nvim/init.vim
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 164 - ((26 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 164
normal! 02|
tabnext 1
badd +1 ~/.config/nvim/lua/plugins/pluginConfigs.lua
badd +2 ~/.config/nvim/init.vim
badd +164 ~/.config/nvim/plugs.vim
badd +7 ~/.local/share/nvim/plugged/bufferline.nvim/lua/bufferline.lua
badd +1 ~/.config/zsh/.zshrc
badd +1 ~/.config/nvim/lua/plugins/cmp-config.lua
badd +1 ~/.local/share/nvim/plugged/bufferline.nvim/nvim/init.vim
badd +1 ~/.local/share/nvim/plugged/bufferline.nvim/nvim/plugs.vim
badd +1 ~/.local/share/nvim/plugged/bufferline.nvim/zsh/.zshrc
badd +1 ~/.local/share/nvim/plugged/bufferline.nvim/nvim/lua/plugins/cmp-config.lua
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
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
