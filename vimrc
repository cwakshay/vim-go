"Set options start
packadd! matchit " To enable usage of % for parenthesis matching
set ruler
filetype plugin indent on
filetype plugin on
set nocompatible
set history=100
if &t_Co > 2 || has("gui_running")
 syntax on
 set hlsearch
endif
set autowrite
set tabstop=4
set softtabstop=4
set expandtab
set showcmd
filetype indent on
set wildmenu
set showmatch
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undo " Set the directory for the persistent undo tree of vim
hi Directory guifg=#FF0000 ctermfg=red " To set the color of the directory

"vim-plug related stuff goes here
" move to previous buffer.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug' " To get help for the vim plug itself.
Plug 'dkarter/bullets.vim' " To add a support for bullets in vim.
Plug 'fatih/vim-go' " To add a IDE kind-off support for go projects.
Plug 'tpope/vim-fugitive' " To add the capability to access git functions from inside vim.
"Plug '907th/vim-auto-save' Do not use as it messes with vim undo command.
"Changes won't be lost as we have swap files already.
Plug 'vim-airline/vim-airline' "To add a nice status line in the end which will have git branch, file name, cursor position etc at the bottom.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " NERDTree for directory exploration and file navigation in the project.
Plug 'ctrlpvim/ctrlp.vim' " To list all the function declarations and jump to it directly.
Plug 'buoto/gotests-vim' " To generate the golang test cases. Plugin to gotests
call plug#end()
"vim-plug related stuff ends here

"key-bindings start #######
let mapleader=","

nnoremap <leader><space> :nohlsearch<CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <C-p> :GoDecls<CR>
map <C-g> :GoDeclsDir<CR>

nnoremap <leader>a :cclose<CR>
nnoremap <leader>al :GoAlternate<CR>
nnoremap <leader>c :NERDTreeFind<CR>
nnoremap <leader>d :GoSameIds<CR>
nnoremap <leader>e :GoTest<CR>
nnoremap <leader>f :GoTestFunc<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>sr :source<space>~/.vimrc<CR>
nnoremap <leader>st :GoFillStruct<CR>
nnoremap <leader>tg :GoTestsAll<CR>
nnoremap <leader>w <C-W><C-W>

"key-bindings end #######

"Autocmd start #########

"NERDTree autocmd
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"vim-go autocmd
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>e  <Plug>(go-test)

"Autocmd end ########

"all vim-go configurations
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_updatetime = 400
let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1 Some error needs a fix
let g:go_info_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_referrers_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_list_type = "quickfix" " To use quickfix for all types of alerts
let g:go_version_warning = 0
