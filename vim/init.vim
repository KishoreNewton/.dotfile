syntax on

set scrolloff=8
set termguicolors     " enable true colors support
"let ayucolor="dark""   " for dark version of theme
set timeoutlen=1000
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
set modifiable
set background=dark
set signcolumn=number
set clipboard=unnamedplus
set guifont=Dank\ Mono
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set clipboard=unnamedplus
set autoread | au CursorHold * checktime | call feedkeys("lh")
set laststatus=0
set guicursor=

highlight Comment cterm=italic gui=italic term=italic
highlight Statement cterm=italic gui=italic term=italic
highlight Type  cterm=italic gui=italic term=italic
highlight PreProc cterm=bold  gui=bold  term=bold guifg=#A7D676
highlight Special  cterm=bold  gui=bold  term=bold
highlight Underlined  cterm=underline  gui=underline  term=underline
highlight CocErrorFloat ctermfg=black guifg=white
highlight CocError ctermfg=white guifg=black
highlight CocWarning ctermfg=white guifg=black
highlight CocInfo ctermfg=white guifg=black
highlight Pmenu ctermbg=gray guibg=#101820
highlight Pmenu ctermbg=gray guifg=#FEE715
highlight PmenuSel ctermbg=gray guibg=#FEE715
highlight PmenuSel ctermbg=gray guifg=#101820

" Color Scheme
highlight Normal guifg=#53cd38
highlight bold guifg=#000000 
highlight Comment guifg=#D1D1D1 gui=italic
highlight String guifg=#FFF066 
highlight Character guifg=#000000 
highlight Number guifg=#EFF0EB gui=bold
highlight Boolean guifg=#86E3CE
highlight Float guifg=#EFF0EB gui=italic
highlight Function guifg=#9DE0AD
highlight Conditional guifg=#CFF4D2 gui=italic
highlight Repeat guifg=#CCABD8 gui=italic
highlight Label guifg=#D3E7EE gui=italic
highlight Operator guifg=#FFDCA2 gui=bold
highlight Keyword guifg=#758EB7 gui=italic
highlight Identifier guifg=#FA897B
" Change Later 
highlight Exception guifg=#AAB6FB gui=bold
highlight Visual term=reverse cterm=reverse guibg=#2C6975
" highlight Include guifg=#000000 gui=italic
" highlight Define guifg=#000000 gui=italic
" highlight Macro guifg=#000000 gui=italic
" highlight PreCondit guifg=#000000
" highlight Typedef guifg=#000000 gui=italic
" highlight SpecialChar guifg=#000000 gui=bold
" highlight Tag guifg=#000000 gui=italic
" highlight Delimiter guifg=#000000 gui=bold
" highlight Debug guifg=#000000 gui=italic
highlight clear SignColumn 

highlight StorageClass guifg=#FAA7B8 gui=italic
highlight Structure guifg=#FB7BBE gui=italic

highlight Special guifg=#FF9CDA gui=italic
highlight SpecialComment guifg=#9B9B9B gui=bold


"highlight Error guifg=#E73213 gui=bold

hi SpellBad ctermfg=black 
hi SpellCap ctermfg=black  
hi SpellLocal ctermfg=black
hi SpellRare ctermfg=black
hi SpellRareUnderlined ctermfg=black cterm=underline
hi SpellLocalUnderlined ctermfg=black cterm=underline
hi SpellCapUnderlined ctermfg=black cterm=underline
hi SpellBadUnderlined ctermfg=black cterm=underline
hi NonText guifg=#C9BBC8 gui=bold
hi TabLine      guifg=#05386B guibg=#FC4445 ctermfg=white ctermbg=238 
hi TabLineSel   guifg=#05386B guibg=#5CDB95 gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi TabLineFill  guifg=#999 guibg=#222  ctermfg=254 ctermbg=238 
hi LineNr guifg=#FDE4E3

call plug#begin('~/.config/nvim/pack')

"Plug 'vim-airline/vim-airline'"
"Plug 'vim-airline/vim-airline-themes'"
Plug 'rust-lang/rust.vim'
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
" Plug 'preservim/nerdtree'"
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'ayu-theme/ayu-vim'
Plug 'elzr/vim-json'
Plug 'google/vim-jsonnet'
Plug 'rust-lang/rust.vim'
"Plug 'powerline/powerline-fonts'"
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
Plug 'puremourning/vimspector'
"Plug 'dense-analysis/ale'"
"Plug 'fannheyward/coc-deno'"
"Plug 'dense-analysis/ale'"
"Plug 'vim-denops/denops.vim'"

call plug#end()

if executable('rg')
  let g:rg_derive_root='true'
endif

let g:coc_snippet_next = '<tab>'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "
let g:ctrlp_use_caching = 0
let g:NERDTreeWinPos = "right"
let g:minimap_auto_start = 1
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar']
let g:minimap_git_colors = 1
let g:minimap_highlight_search = 1
let g:ycm_semantic_triggers = { 'c': [ 're!\w{2}' ] }
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:vim_json_syntax_conceal = 0
" let g:ale_fixers = {'typescript': ['deno']}"
" let g:ale_fix_on_save = 1 " run deno fmt when saving a buffer"

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

nmap <F6> :NERDTreeToggle<CR>
"nmap gr <Plug>(ale_rename)"
"nmap gR <Plug>(ale_find_reference)"
"nmap gd <Plug>(ale_go_to_definition)"
"nmap gD <Plug>(ale_go_to_type_definition)"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"colorscheme slate"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" use <c-space>for trigger completion
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()


function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ CheckBackSpace() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
		\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

