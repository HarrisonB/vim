set number
execute pathogen#infect()
colorscheme molokai
syntax on
filetype plugin indent on
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
	    let g:clang_library_path=s:clang_library_path
    endif
set nocompatible
" Keymappings
ino jj <Esc>l
cno jj <C-c>l
vno v <Esc>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
