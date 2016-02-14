set nocompatible

" Required Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" List of Vundle bundles 
Plugin 'L9'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/closeb'
Plugin 'kien/ctrlp.vim'
Plugin 'fs111/pydoc.vim'
Plugin 'bling/vim-airline'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'lervag/vimtex'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mattn/emmet-vim'

" Required Vundle setup
call vundle#end()
filetype plugin indent on

set number
" execute pathogen#infect()
colorscheme molokai
syntax on
set tabstop=4
set shiftwidth=4
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
" let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
" if isdirectory(s:clang_library_path)
" 	let g:clang_library_path=s:clang_library_path
" endif
" let g:SuperTabDefaultCompletionType = "<c-n>"
let g:pymode_rope_guess_project=0
" Keymappings
map <SPACE> <leader>
" Allows buffers to hide
set hidden
nmap <leader>T :enew<CR>
" Move to next and previous butter
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
" Close current buffer and move to previous one
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their statuses
nmap <leader>bl :ls<CR>
" Enable the list of buffers
" nmap <leader>bg<
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
ino jj <Esc>l
cno jj <C-c>l
vno v <Esc>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <leader>k 10k
map <leader>j 10j
let &colorcolumn=join(range(81,999),",")  " Sets cols 80s to a different color
" autocmd BufNewFile,BufRead *.scss
" set ft=scss.css


augroup latexSurround
 autocmd!
 autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
 let b:surround_{char2nr("e")}
   \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
 let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

