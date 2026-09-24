" =============================================================================
" ~/.vimrc  -  Bootstrap only
" =============================================================================
" The real Vim configuration lives in ~/.config/vim/vimrc (XDG-style layout).
" Vim does not look there by default, so this file wires up the runtimepath
" and sources it. Keep this file minimal.
"
" Alternatively, you can avoid this file entirely by exporting:
"   export VIMINIT='source $HOME/.config/vim/vimrc'
" in your shell profile.
" =============================================================================

set nocompatible

" Use ~/.config/vim as the Vim config home
set runtimepath^=$HOME/.config/vim
set runtimepath+=$HOME/.config/vim/after

if filereadable(expand('$HOME/.config/vim/vimrc'))
  source $HOME/.config/vim/vimrc
endif
