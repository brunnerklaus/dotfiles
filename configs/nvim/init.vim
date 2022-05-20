syntax on
highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

let g:_vimrc_base = expand('<sfile>:p:h')

" plug dir
" let g:plugin_path = expand('~/.config/nvim-plug')

" keep cursor as block regardels of mode
set guicursor=

" don't highlight matches
set noshowmatch

set spelllang=en

set relativenumber
set nu

set autoread

" jumps as type to next match
" set incsearch
" don't jump to matches
set nohlsearch

set hidden

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" stop line breaking
set nowrap

" For example, /The would find only 'The', while /the would find 'the' or 'The' etc.
set smartcase

set noswapfile
set nobackup

set undodir=~/.vim/undodir
set undofile

" enable 'true color' support - https://github.com/rakr/vim-one/blob/master/README.md#true-color-support
set termguicolors

" display 8 lines after EOF
set scrolloff=8

" display status line 0 - never, 1 - if 2 or more widows are present, 2 - always
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)}

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.config/nvim-plug')
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'onsails/lspkind-nvim'

" colorscheme
Plug 'NLKNguyen/papercolor-theme'

" Git
Plug 'airblade/vim-gitgutter'

" Jsonnet syntax
Plug 'google/vim-jsonnet'

Plug 'tpope/vim-fugitive'

Plug 'vim-utils/vim-man'

Plug 'mbbill/undotree'

Plug 'sheerun/vim-polyglot'

Plug 'ThePrimeagen/vim-be-good'
call plug#end()

" functions
function! CleanK8s()
    :g/^status:/norm dG
    :g/resourceVersion:/norm dd
    :g/selfLink:/norm dd
    :g/uid:/norm dd
    :g/creationTimestamp:/norm dd
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" sets
set background=dark
colorscheme PaperColor

" buffer for sed - %s/foo/bar/
set inccommand=split

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

imap <expr> <CR> pumvisible()
                \ ? "\<C-Y>"
                \ : "<CR>"

" Avoid showing message extra message when using completion
set shortmess+=c

" mappings
let mapleader = " "
nnoremap <C-l> gt
nnoremap <C-h> gT

" greatest remap ever
vnoremap <leader>h "_dP

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <silent> <Leader>R :set rnu! \| set nu!<CR>
nnoremap <silent> <Leader>S :set spell!<CR>
nnoremap <leader>u :UndotreeShow<CR>

" telescope
set  runtimepath+=/usr/local/opt/fzf
nnoremap <Leader>f :lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>l :Telescope keymaps<CR>

nnoremap <Leader><Leader> :set cursorcolumn!<CR>

nnoremap <Leader>gg :lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>gw :lua require'telescope.builtin'.grep_string{}<CR>

cmap <C-a> <Home>

nnoremap <silent> <Leader>c :call CleanK8s()<CR>