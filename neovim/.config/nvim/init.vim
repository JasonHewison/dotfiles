let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/.config/nvim/plugged')

" colorschemes

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'pangloss/vim-javascript', {'commit': '871ab29'}

Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder, mapped to <leader>t
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
Plug 'tpope/vim-fugitive' " amazing git wrapper for vim
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'sjl/vitality.vim'

Plug 'elzr/vim-json', {'commit': 'f5e3181'}
Plug 'mxw/vim-jsx', {'commit': 'd0ad98c'}
Plug 'tpope/vim-markdown', {'commit': 'dcdab0c'}
Plug 'fatih/vim-nginx'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tmux-plugins/vim-tmux'

Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'wokalski/autocomplete-flow'
" You will also need the following for function argument completion:
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

filetype plugin indent on

let g:rehash256=1

let mapleader = ","
let g:mapleader = ','

set mouse=a

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

" Use System Clipboard
set clipboard=unnamed

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

set tabstop=2
set shiftwidth=2

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
hi javaRepeat ctermfg = green
hi javaType ctermfg = green
hi javaStorageClass ctermfg = green cterm=bold
hi javaDocTags ctermfg = green
hi Conditional ctermfg = green
hi LineNr ctermfg = magenta
hi Comment ctermfg = red
hi Statement ctermfg = blue
hi Function ctermfg = blue
hi Identifier ctermfg = blue
hi Exception ctermfg = green
hi Special ctermfg = green
hi SpecialKey ctermfg = DarkGray
hi String ctermfg = yellow
hi MatchParen ctermbg=none cterm=underline ctermfg=magenta
hi Search cterm=NONE ctermfg=NONE ctermbg=DarkGray
hi Cursor               ctermfg=none    ctermbg=241             cterm=none              guifg=NONE              guibg=#656565   gui=none

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
"	Tern
"
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
endif

autocmd BufNewFile,BufRead .eslintrc set ft=javascript

"
" Neoformat
"
"
"neoformat: format javascript on save
autocmd BufWritePre *.js Neoformat

"
" Ale
"
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" Write this in your vimrc file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

nmap <Leader><Space>o :lopen<CR>
nmap <Leader><Space>c :lclose<CR>
nmap <Leader><Space>, :ll<CR>
nmap <Leader><Space>n :lnext<CR>
nmap <Leader><Space>p :lprev<CR>

let g:vitality_always_assume_iterm = 1

let g:airline_theme='kalisi'
" let g:airline_theme='base16_chalk'
" let g:airline_theme='base16_greenscreen'
" let g:airline_theme='term'

call remote#host#RegisterPlugin('python3', '/home/shougo/work/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
     \ ])
