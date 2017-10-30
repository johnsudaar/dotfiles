
set termguicolors

set background=dark
filetype plugin on


call plug#begin()
Plug 'Shougo/dein.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-fugitive'
Plug 'kchmck/vim-coffee-script'
Plug 'mileszs/ack.vim'
Plug 'leafgarland/typescript-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Valloric/ListToggle'
Plug 'scrooloose/nerdcommenter'
Plug 'iCyMind/NeoSolarized'
Plug 'tpope/vim-haml'
Plug 'rhysd/vim-grammarous'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'jiangmiao/auto-pairs'
call plug#end()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

:let mapleader = ","

syntax enable

"Better pane navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

:set number

:set tabstop=2
:set shiftwidth=2
:set expandtab

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
let g:go_fmt_command = "goimports"

autocmd BufWritePre * %s/\s\+$//e

colorscheme NeoSolarized

let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:neomake_ruby_enabled_makers = ['rubocop', 'mri']

" Better QuickFix window height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction


" NerddTree Configuration
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDDefaultAlign = 'left'
let g:NERDTreeShowHidden = 1
let NERDTreeMapOpenVSplit = "v"
let NERDTreeMapOpenSplit = "h"

" Neomake Configuration
autocmd! BufWritePost * Neomake

" Deoplete configuration
let g:deoplete#enable_at_startup = 1
"    Complete with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" AutoIndent with <leader> m
nmap <leader>m mZgg=G'Z
" Disable hilight
nmap <Leader>k :noh<CR>

" Spell check
set spell spelllang=en_us

" Trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" nonascii chars

au BufReadPost * syntax match nonascii "[^\u0000-\u007F]" containedin=ALL
highlight nonascii guibg=Red ctermbg=1 term=standout

" Mouse mode
set mouse=a

" Highlight cursor line
set cursorline

" Jump to declarations
nnoremap <C-g>d :GoDecls<CR>
" Jump to declarations in current directory
nnoremap <C-g>D :GoDeclsDir<CR>

" open the list of alternatives
map <Leader>i z=
" go to the next misspelled word
map <Leader>o ]s
" add the current word to the dictionary
map <Leader>p zg

" Open grammar info window
nmap <Leader>a <Plug>(grammarous-move-to-info-window)
" Go to next grammar error
nmap <Leader>z <Plug>(grammarous-move-to-next-error)
" Fix current grammar error
nmap <Leader>e <Plug>(grammarous-fixit)
