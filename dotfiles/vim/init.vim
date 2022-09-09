
set termguicolors

set background=dark
filetype plugin on


call plug#begin()
Plug 'Shougo/dein.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'mxw/vim-jsx'
Plug 'ngmy/vim-rubocop'
Plug 'gabrielelana/vim-markdown'
Plug 'airblade/vim-gitgutter'

" See https://github.com/mxw/vim-jsx/issues/10 for this issue
Plug 'sheerun/vim-polyglot', { 'do': 'rm ~/.config/nvim/plugged/vim-polyglot/after/indent/javascript.vim' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'sebastianmarkow/deoplete-rust'

Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'

Plug 'junegunn/vim-easy-align'

Plug 'rust-lang/rust.vim'

Plug 'hashivim/vim-terraform'

Plug 'jxnblk/vim-mdx-js'

Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'

"Gonvim
Plug 'equalsraf/neovim-gui-shim'

Plug 'liuchengxu/vim-which-key'
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

:set t_Co=256

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

" vim-go

" Coloration syntaxique
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" Whenever we save, call
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ 'goimports': '-local github.com/Scalingo',
  \ }
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_decls_includes = "func,type" " GoDecls gives functions and types names
let g:go_auto_type_info = 0 " Set to 1 to automatically fetch the signature of everything

let g:go_list_type = "quickfix" "


autocmd BufWritePre * %s/\s\+$//e

colorscheme NeoSolarized

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
nnoremap <C-g>f :GoDoc<CR>

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

" Show spaces and tabs
:set list
:hi NonText ctermfg=7 guifg=gray25

" Handle ruby indentation
autocmd FileType ruby set tabstop=8|set shiftwidth=2|set expandtab

" Tags bar
autocmd VimEnter * TagbarToggle

" CtrlP

function! CtrlPCommand()
    let c = 0
    let wincount = winnr('$')
    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    exec 'CtrlP'
  endfunction

let g:ctrlp_cmd = 'call CtrlPCommand()'

let g:ctrlp_custom_ignore = 'node_modules\|vendor\|tmp'

" JSX
let g:jsx_ext_required = 0

nmap <Leader>w :RuboCop --auto-correct<CR>

au FileType markdown vmap <Leader>t :EasyAlign*<Bar><Enter>

" Rust

let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME.'/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'

" Terraform

let g:terraform_align=1
let g:terraform_fmt_on_save=1
"
" ALE config

let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E!'
let g:ale_sign_warning = 'W!'
let g:ale_fix_on_save = 1

" Which key

" "nnoremap <silent> <leader> :WhichKey ',' <CR>
