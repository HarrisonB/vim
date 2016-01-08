set number
execute pathogen#infect()
colorscheme molokai
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
	let g:clang_library_path=s:clang_library_path
endif
set nocompatible
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:pymode_rope_guess_project=0
set runtimepath-=~/.vim/bundle/vim-autocomplpop
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
autocmd BufNewFile,BufRead *.scss
set ft=scss.css
