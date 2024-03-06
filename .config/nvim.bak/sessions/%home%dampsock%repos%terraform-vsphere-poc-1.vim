let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/repos/terraform-vsphere-poc-1
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +6 import/terracognita/terracognita-secrets
badd +14 import/terracognita/terracognita-run.sh
argglobal
%argdel
$argadd import/terracognita/terracognita-secrets
$argadd import/terracognita/terracognita-run.sh
edit import/terracognita/terracognita-run.sh
argglobal
if bufexists(fnamemodify("import/terracognita/terracognita-run.sh", ":p")) | buffer import/terracognita/terracognita-run.sh | else | edit import/terracognita/terracognita-run.sh | endif
if &buftype ==# 'terminal'
  silent file import/terracognita/terracognita-run.sh
endif
balt import/terracognita/terracognita-secrets
let s:l = 14 - ((13 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 036|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
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
