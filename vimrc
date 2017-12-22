"" ~/.vimrc

set nocompatible
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set fileformats=unix,dos,mac
set nowrap
set sidescroll=5
set hidden
set colorcolumn=80

syntax on
set number relativenumber
set mouse=a
set clipboard=unnamedplus

set dir=~/.vim/swap//,~/tmp//,/tmp//,.

" wildmode
set wildmode=longest,list,full
set wildmenu

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Trailing whitespace
set list listchars=tab:»·,trail:·,precedes:<,extends:>
autocmd FileType c,cpp,java,php,javascript,smarty,xml autocmd BufWritePre <buffer> :%s/\s\+$//e

" Better line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" Enable spell-checking (germa) and text wrapping for commit messages
autocmd FileType svn setlocal spell spelllang=de_de tw=72
autocmd FileType gitcommit setlocal spell spelllang=en_us tw=72


" ctags - locate tags file in current directory, then parents
set tags=tags;

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

colorscheme Tomorrow-Night
set fillchars+=vert:\│
hi vertsplit guifg=fg guibg=bg ctermbg=bg

" GVIM
set anti enc=utf-8
set guioptions-=T
set guifont=Source\ Code\ Pro\ 12

" Eliminating delays on ESC
" http://usevim.com/2013/07/24/powerline-escape-fix/
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=500
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" PLUGINS
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'joonty/vdebug'
Plugin 'blueyed/smarty.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'

call vundle#end()
filetype plugin indent on


" vim-airline
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" phpmd disabled
let g:syntastic_php_checkers = ['php']


" NERDtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" CtrlP
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_height = 18
let g:ctrlp_custom_ignore = '\v[\/]smarty\/templates_c$'

" Vdebug
let g:vdebug_options = {}
let g:vdebug_options["watch_window_style"] = 'compact'

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<Right>"
let g:UltiSnipsJumpBackwardTrigger="<Left>"
let g:UltiSnipsEditSplit="vertical"

augroup UltiSnipsConfig
    au!
    au FileType smarty UltiSnipsAddFiletypes smarty.html.javascript.php
    au FileType html   UltiSnipsAddFiletypes html.javascript.php
augroup END

" emmet
let g:user_emmet_mode='a'

" MAPPINGS

" Map leader to ,
let mapleader=','

" C-s save file
nmap <C-s> :w<CR>

" Centering the search next / search prev
nmap n nzz
nmap N Nzz

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Set working directory
nnoremap <Leader>. :lcd %:p:h<CR>

" Opens an editr command with the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" CtrlP Buffers
nnoremap <Leader>b :CtrlPBuffer<CR>

" svn diff
map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg

" Window navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Spell checking
nnoremap <Leader>sd :setlocal spell spelllang=de_de<CR>
nnoremap <Leader>se :setlocal spell spelllang=en_us<CR>

" Insetr word under cursor to CtrlP
nmap <Leader>p :CtrlP<CR><C-\>w

