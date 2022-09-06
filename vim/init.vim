syntax on
filetype plugin on

set scrolloff=8
set termguicolors     " enable true colors support
set timeoutlen=1000
set ttimeoutlen=0
set number
set relativenumber
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set omnifunc=syntaxcomplete#Complete
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
set updatetime=100
set guifont=Dank\ Mono
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set clipboard=unnamedplus
set autoread | au CursorHold * checktime | call feedkeys("lh")
set laststatus=2
set guicursor=

highlight Comment cterm=italic gui=italic term=italic
highlight Statement cterm=italic gui=italic term=italic
highlight Type  cterm=italic gui=italic term=italic
highlight PreProc cterm=bold  gui=bold  term=bold guifg=#A7D676
highlight Special  cterm=bold  gui=bold  term=bold
highlight Underlined  cterm=underline  gui=underline  term=underline
highlight Pmenu ctermbg=gray guibg=#101820
highlight Pmenu ctermbg=gray guifg=#FEE715
highlight PmenuSel ctermbg=gray guibg=#FFF38C
highlight PmenuSel ctermbg=gray guifg=#101820
highlight netrwDir guifg=#FF7F50	

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
hi TabLine      guibg=#355C7D ctermfg=NONE ctermbg=NONE cterm=italic
hi TabLineSel   guifg=#05386B guibg=#5CDB95 gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi TabLineFill  guifg=#111111 guibg=#000000  ctermfg=254 ctermbg=238 
hi LineNr guifg=#FDE4E3
hi StatusLine guifg=#FDE4E3 guibg=#000000 ctermfg=NONE ctermbg=NONE cterm=italic
hi StatusLineNC guifg=#FF5733 
hi WinSeparator guibg=None

call plug#begin('~/.config/nvim/pack')

Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'google/vim-jsonnet'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'wbthomason/packer.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'L3MON4D3/LuaSnip'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "
let g:ycm_semantic_triggers = { 'c': [ 're!\w{2}' ] }
let g:copilot_node_command = "~/.nvm/versions/node/v16.15.0/bin/node"
let g:copilot_no_tab_map = v:true
let g:vim_json_syntax_conceal = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap gp :silent %!prettier --stdin-filepath %<CR>

imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" nmap <silent> gd <Plug>(lua vim.lsp.buf.declaration())
" nmap <silent> gD <Plug>(lua vim.lsp.buf.definition())
" nmap <silent> gr <Plug>(lua vim.lsp.buf.references())

" require plugin configs
lua require('kishorenewton')

" autocmd BufWritePost * silent! execute '!git add % && git commit -m %' "
autocmd BufWritePost *.ts silent! execute '!prettier --write %'
autocmd BufWritePost *.js silent! execute '!prettier --write %'

