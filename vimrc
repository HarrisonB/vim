set nocompatible

call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.force
		!./install.sh
	endif
endfunction

Plug 'L9'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fs111/pydoc.vim' 
Plug 'itchyny/lightline.vim'
Plug 'critiqjo/vim-bufferline'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'lervag/vimtex'
Plug 'junegunn/seoul256.vim' " A beautiful colorscheme!
Plug 'junegunn/vim-easy-align' " To easily align repeating structures
Plug 'vimwiki/vimwiki' " A wiki in vim
Plug 'jonstoler/werewolf.vim' " Changing colorscheme based on time
Plug 'mhinz/vim-startify' " Show useful menu on vim's startup
Plug 'edkolev/tmuxline.vim' " Customize tmux status bar in .vimrc
Plug 'edkolev/promptline.vim' " Customize shell prompt
Plug 'wsdjeg/vim-cheat' " Open ~/.cheat/ files easily in vim
Plug 'timakro/vim-searchant' " Highlight *all* of the matches in a search

" Not used very requently:
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim' 

" Trying out
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-unimpaired'

" Neovim
Plug 'neomake/neomake'
" function! DoRemote(arg)
"   UpdateRemotePlugins
" endfunction
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Plug 'zchee/deoplete-jedi'

" Required vim-plug
call plug#end()

filetype plugin indent on


" Colors and other essentials
set number
set hidden
set tabstop=4
set shiftwidth=4
set cursorline
syntax on
colo seoul256
let g:werewolf_day_themes = ['seoul256-light']
let g:werewolf_night_themes = ['seoul256']


" YouCompleteMe configuration

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data = ['&filetype']
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
	let g:clang_library_path=s:clang_library_path
endif

" Neocomplete
autocmd! BufWritePost * Neomake
" let g:neomake_open_list = 2


" Vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki',
			\'template_path': '~/Dropbox/vimwiki/templates/',
			\'template_default': 'default',
			\'template_ext': '.html',
			\'auto_export': 1,
			\'auto_toc': 0}]

" Keymappings
map <SPACE> <leader>
" Allows buffers to hide
nmap <leader>T :enew<CR>
" Move to next and previous butter
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
" Close current buffer and move to previous one
nmap <leader>w :bp <BAR> bd #<CR>
" Show all open buffers and their statuses
nmap <leader>bl :ls<CR>

ino jj <Esc>l
cno jj <C-c>l
vno v <Esc>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <leader>k 10k
map <leader>j 10j
let &colorcolumn=join(range(80,999),",")  " Sets cols 79 to a different color

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

nnoremap <C-P> :FZF<CR>

augroup latexSurround
	autocmd!
	autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
	let b:surround_{char2nr("e")}
				\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
	let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

let g:vimtex_quickfix_ignore_all_warnings = 1

let g:vimtex_view_general_viewer
			\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
	if !a:status | return | endif

	let l:out = b:vimtex.out()
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
	endif
endfunction

" lightline and bufferline settings
set showtabline=2
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
let g:bufferline_fname_mod = ':~:.'
let g:bufferline_pathshorten = 1
let g:lightline = {
			\  'colorscheme': 'seoul256',
			\  'active':{
			\		'left': [ [ 'mode', 'paste' ], ['fugitive', 'filename'], ['ctrlpmark'] ],
			\		'right': [ ['lineinfo' ] , ['filetype'], ['fileencoding'], ]
			\  },
			\  'tab': {
			\    'active': ['tabnum'],
			\    'inactive': ['tabnum']
			\  },
			\  'tabline': {
			\ 	 	'left': [ ['tabs'], ['bufferline'] ],
			\  		'right': [ ['fileencoding'] ]
			\  },
			\  'component': {
			\		'readonly': '%{&readonly?"⭤ ":""}',
			\   	'bufferline': '%{MyBufferlineRefresh()}' . bufferline#get_status_string('TabLineSel', 'LightLineLeft_tabline_tabsel_1'),
			\   	'fileencoding': '%{&fenc}',
			\  },
			\  'component_function': {
			\		'ctrlpmark': 'CtrlPMark',
			\		'fugitive': 'LightLineFugitive',
			\		'filename': 'LightLineFilename',
			\  		},
			\ }
let lightline.enable = {
			\ 'statusline': 1,
			\ 'tabline': 1
			\}
function! MyBufferlineRefresh()
	call bufferline#refresh_status()
	let rlen = 4*tabpagenr('$') + len(&fenc) + 8
	call bufferline#trim_status_info(&columns - rlen)
	return ''
endfunction
function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') :
	''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	let fname = expand('%:t')
	return fname == '__Tagbar__' ? 'Tagbar' :
				\ fname == 'ControlP' ? 'CtrlP' :
				\ fname == '__Gundo__' ? 'Gundo' :
				\ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
				\ fname =~ 'NERD_tree' ? 'NERDTree' :
				\ &ft == 'unite' ? 'Unite' :
				\ &ft == 'vimfiler' ? 'VimFiler' :
				\ &ft == 'vimshell' ? 'VimShell' :
				\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
	if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
		call lightline#link('iR'[g:lightline.ctrlp_regex])
		return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
					\ , g:lightline.ctrlp_next], 0)
	else
		return ''
	endif
endfunction

let g:ctrlp_status_func = {
			\ 'main': 'CtrlPStatusFunc_1',
			\ 'prog': 'CtrlPStatusFunc_2',
			\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
	let g:lightline.ctrlp_regex = a:regex
	let g:lightline.ctrlp_prev = a:prev
	let g:lightline.ctrlp_item = a:item
	let g:lightline.ctrlp_next = a:next
	return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
	return
	lightline#statusline(0)
endfunction

function! LightLineFugitive()
	try
		if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
			let mark = ''  " edit here for cool mark
			let _ = fugitive#head()
			return _ !=# '' ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction

let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a %D',
      \'y'    : '%I:%M %p',
      \'z'    : '#H'
	  \}
" sections (a, b, c, x, y, z, warn) are optional
let g:promptline_preset = {
        \'a' : [ promptline#slices#cwd() ],
        \'b' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'c' : [],
        \'y' : [],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" available slices:
"
" promptline#slices#cwd() - current dir, truncated to 3 dirs. To configure: promptline#slices#cwd({ 'dir_limit': 4 })
" promptline#slices#vcs_branch() - branch name only. By default, only git branch is enabled. Use promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1}) to enable check for svn, mercurial and fossil branches. Note that always checking if inside a branch slows down the prompt
" promptline#slices#last_exit_code() - display exit code of last command if not zero
" promptline#slices#jobs() - display number of shell jobs if more than zero
" promptline#slices#battery() - display battery percentage (on OSX and linux) only if below 10%. Configure the threshold with promptline#slices#battery({ 'threshold': 25 })
" promptline#slices#host() - current hostname.  To hide the hostname unless connected via SSH, use promptline#slices#host({ 'only_if_ssh': 1 })
" promptline#slices#user()
" promptline#slices#python_virtualenv() - display which virtual env is active (empty is none)
" promptline#slices#git_status() - count of commits ahead/behind upstream, count of modified/added/unmerged files, symbol for clean branch and symbol for existing untraced files
"
" any command can be used in a slice, for example to print the output of whoami in section 'b':
"       \'b' : [ '$(whoami)'],
"
" more than one slice can be placed in a section, e.g. print both host and user in section 'a':
"       \'a': [ promptline#slices#host(), promptline#slices#user() ],
"
" to disable powerline symbols
let g:promptline_powerline_symbols = 0


set noshowmode
