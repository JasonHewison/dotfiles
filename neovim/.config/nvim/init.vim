let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'chriskempson/base16-vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'morhetz/gruvbox'

Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder, mapped to <leader>t
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
Plug 'tpope/vim-fugitive' " amazing git wrapper for vim
Plug 'Shougo/deoplete.nvim' " keyword completion
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'benekastah/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'

Plug 'fatih/vim-nginx'

call plug#end()

filetype plugin indent on

set background=dark
colorscheme gruvbox
hi clear Conceal

let mapleader = ","
let g:mapleader = ','

" Reload file when it changes
set autoread

" Not writes are annoying
set confirm

" Always UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Disable Ex mode
nnoremap Q <Nop>

" faster redrawing
set ttyfast

" setup commandline
if has('cmdline_info')
  set ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
  set showcmd
endif

if has('statusline')
  set laststatus=2
  set statusline=%<%f\ " Filename
  set statusline+=%w%h%m%r " Options
  " set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y] " Filetype
  set statusline+=\ [%{getcwd()}] " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

" Set title of window
set title

" Show line numbers
set number

" Turn off line wrap
set nowrap

" Set display characters for tab and trailing
set list lcs=trail:·,tab:▸\

" Highlight matching brackets
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Set 4 lines to the cursor - when moving vertically using j/k
set so=4

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set ; to do what : does so you don't have to hold shift and accidentally do
" the wrong command.
nnoremap ; :

" Use system clipboard
set clipboard=unnamed

let base16colorspace=256
set t_Co=256
highlight Comment cterm=italic

" ,, to save
nmap <leader>, :w<cr>

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" enable . command in visual mode
vnoremap . :normal .<cr>

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

"
"	NERDTree
"
" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" remove some files by extension
let NERDTreeIgnore = ['\.js.map$']
" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

"
"	CtrlP
"
" map fuzzyfinder (CtrlP) plugin
" nmap <silent> <leader>t :CtrlP<cr>
nmap <silent> <leader>r :CtrlPBuffer<cr>
let g:ctrlp_map='<leader>t'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'
" only show files that are not ignored by git
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" search the nearest ancestor that contains .git, .hg, .svn
let g:ctrlp_working_path_mode = 2

"
"	Fugitive
"
" Fugitive Shortcuts
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

"
"	Deoplete
"
set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"
"	Omnifuncs
"
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

"
"	Tern
"
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
endif

"
"	Neomake
"
autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }

let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_open_list = 2

let g:neomake_javascript_enabled_makers = ['eslint']

nmap <Leader><Space>o :lopen<CR>
nmap <Leader><Space>c :lclose<CR>
nmap <Leader><Space>, :ll<CR>
nmap <Leader><Space>n :lnext<CR>
nmap <Leader><Space>p :lprev<CR>


call remote#host#RegisterPlugin('python3', '/home/shougo/work/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
     \ ])

" vim-airline ---------------------------------------------------------------{{{
let g:airline#extensions#tabline#enabled = 1
set hidden
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
nmap <leader>. :bprevious<CR>
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h13
"}}}

