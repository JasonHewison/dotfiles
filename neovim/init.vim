let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'arcticicestudio/nord-vim'

Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on

let g:rehash256=1

let mapleader = ","
let g:mapleader = ','

set mouse=a  " Add mouse support for 'all' modes, may require iTerm
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

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

set statusline=%=%l:%c\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set cursorline
set noshowmode

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

set tw=0

" Set ; to do what : does so you don't have to hold shift and accidentally do
" the wrong command.
nnoremap ; :

" Use system clipboard
set clipboard=unnamed

let base16colorspace=256
set t_Co=256

syntax on
set background=dark


let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_comment_brightness = 12
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1

set termguicolors

colorscheme nord
let g:gitgutter_override_sign_column_highlight = 0
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi StatusLine ctermbg=NONE cterm=NONE


" ,, to save
nmap <leader>, :w<cr>

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" enable . command in visual mode
vnoremap . :normal .<cr>

" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

nmap <silent> <leader>t :GFiles<cr>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }

" vim-polyglot
let g:javascript_plugin_jsdoc = 1

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
" Neoformat
"
"
"neoformat: format javascript on save
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.json Neoformat
autocmd BufWritePre *.jsx Neoformat
autocmd BufWritePre *.elm Neoformat
autocmd BufWritePre *.fish Neoformat
autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.css Neoformat
autocmd BufWritePre *.sass Neoformat
autocmd BufWritePre *.scss Neoformat
autocmd BufWritePre *.svg Neoformat

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

let g:ale_echo_msg_format = '[%linter%] %s'

nmap <Leader><Space>o :lopen<CR>
nmap <Leader><Space>c :lclose<CR>
nmap <Leader><Space>, :ll<CR>
nmap <Leader><Space>n :lnext<CR>
nmap <Leader><Space>p :lprev<CR>

let g:python_host_prog = '/Users/jasonhewison/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/jasonhewison/.pyenv/versions/neovim3/bin/python'

call remote#host#RegisterPlugin('python3', '/home/shougo/work/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
     \ ])
