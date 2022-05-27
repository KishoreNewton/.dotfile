syntax on

set scrolloff=8
"set termguicolors"     " enable true colors support
"let ayucolor="dark""   " for dark version of theme
"set timeoutlen=1000

set ttimeoutlen=0
set number
set relativenumber
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set completeopt+=menuone,noselect,noinsert " don't insert text automatically
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set invnumber
set nohlsearch
set belloff=all
set mouse=a
set relativenumber
set exrc
set background=dark
set clipboard=unnamedplus
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set autoread | au CursorHold * checktime | call feedkeys("lh")
set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
set guicursor=

highlight Comment cterm=italic gui=italic term=italic
highlight Statement cterm=italic gui=italic term=italic
highlight Type  cterm=italic gui=italic term=italic
highlight PreProc cterm=bold  gui=bold  term=bold
highlight Special  cterm=bold  gui=bold  term=bold
highlight Underlined  cterm=underline  gui=underline  term=underline
highlight CocErrorFloat ctermfg=black guifg=white
highlight CocError ctermfg=white guifg=black
highlight CocWarning ctermfg=white guifg=black
highlight CocInfo ctermfg=white guifg=black

hi SpellBad ctermfg=black 
hi SpellCap ctermfg=black  
hi SpellLocal ctermfg=black
hi SpellRare ctermfg=black
hi SpellRareUnderlined ctermfg=black cterm=underline
hi SpellLocalUnderlined ctermfg=black cterm=underline
hi SpellCapUnderlined ctermfg=black cterm=underline
hi SpellBadUnderlined ctermfg=black cterm=underline

call plug#begin('~/.config/nvim/pack')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'burntsushi/ripgrep'
Plug 'ms-jpq/coq_nvim'
Plug 'jameshiew/nvim-magic'
Plug 'folke/trouble.nvim'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install'  }
Plug 'lyuts/vim-rtags'
Plug 'preservim/nerdtree'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'ayu-theme/ayu-vim'
Plug 'elzr/vim-json'
Plug 'google/vim-jsonnet'
Plug 'powerline/powerline-fonts'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'junegunn/fzf'
Plug 'hail2u/vim-css3-syntax'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'junegunn/fzf.vim'
"Plug 'neoclide/coc.nvim'"
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'iamcco/diagnostic-languageserver'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
"Plug 'dense-analysis/ale'"
"Plug 'fannheyward/coc-deno'"
"Plug 'dense-analysis/ale'"
"Plug 'vim-denops/denops.vim'"

call plug#end()

if executable('rg')
  let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#show_coc_status = 1
let mapleader = " "
let g:ctrlp_use_caching = 0
let g:NERDTreeWinPos = "right"
let g:minimap_auto_start = 1
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar']
let g:minimap_git_colors = 1
let g:minimap_highlight_search = 1
let g:ycm_semantic_triggers = { 'c': [ 're!\w{2}' ] }
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:vim_json_syntax_conceal = 0
" let g:ale_fixers = {'typescript': ['deno']}"
" let g:ale_fix_on_save = 1 " run deno fmt when saving a buffer"

nnoremap <leader>h :wincmd h<CR>
"nnoremap <leader>j :wincmd j<CR>"
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

nmap <F6> :NERDTreeToggle<CR>
nmap gr <Plug>(ale_rename)
nmap gR <Plug>(ale_find_reference)
nmap gd <Plug>(ale_go_to_definition)
nmap gD <Plug>(ale_go_to_type_definition)

"colorscheme slate"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
