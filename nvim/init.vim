" Enable syntax highlighting.
syntax on

set synmaxcol=0    " No limit on syntax highlighting line length

" Enable syntax highlighting if it was previously turned off.
syntax enable

" Enable filetype detection, plugin, and indentation rules.
filetype plugin indent on

" Set the color scheme to 'hackertheme'.
colorscheme hackertheme

" Automatically save changes to all modified buffers.
set autowriteall

" Disable line wrapping.
set nowrap

" Set the number of lines to keep above and below the cursor. Here, it is 0.
set scrolloff=0

" Enable true color support.
set termguicolors

" The time Vim waits after a key is pressed to see if it is part of a key code.
set timeoutlen=1000

" Time Vim waits after an escape sequence to decide it is not a key code.
set ttimeoutlen=0

" Show line numbers relative to the current cursor position.
set relativenumber

" Disable the error bell sound.
set noerrorbells

" Set tab stops, and the width for soft tab stops.
set tabstop=2 softtabstop=2

" Set the number of spaces to use for each step of (auto)indent.
set shiftwidth=2

" Function to be used for omni-completion.
set omnifunc=syntaxcomplete#Complete

" Use spaces instead of tabs.
set expandtab

" Enable smart indentation.
set smartindent

" Show absolute line numbers.
set nu

" Show both absolute and relative line numbers.
set number relativenumber

" Set the time after which the swap file is written to disk.
set updatetime=2000

" Adjust the completeopt setting to enhance completion menu behavior.
set completeopt+=menuone,noselect,noinsert

" Enable smart case sensitivity for searches.
set smartcase

" Disable swap file creation.
set noswapfile

" Disable backup file creation.
set nobackup

" Set the directory for undo files.
set undodir=~/.nvim/undodir

" Enable undo file creation to make undo information persistent.
set undofile

" Enable incremental search.
set incsearch

" Toggle the display of line numbers.
set invnumber

" Turn off highlighting search matches.
set nohlsearch

" Disable all bell sounds.
set belloff=all

" Enable mouse support in all modes.
set mouse=a

" Allow Vim to read .vimrc file in the current directory.
set exrc

" Allow modifications to the buffer.
set modifiable

" Set the background color scheme to dark.
set background=dark

" Set the sign column to display next to line numbers.
set signcolumn=yes

" Set the clipboard to use the system clipboard (+ register).
set clipboard=unnamedplus

" Reduce the update time to make Vim more responsive.
set updatetime=100

" Set the GUI font to 'Dank Mono'.
set guifont=Dank\ Mono

" Define cursor shapes and behaviors in different modes.
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
           \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
           \,sm:block-blinkwait175-blinkoff150-blinkon175

" Repeat clipboard setting; unnecessary if already set.
set clipboard=unnamedplus

" Run checktime and redraw commands when cursor is held in one place.
au CursorHold * checktime | redraw!

" Always display the status line.
set laststatus=2

" Enable handling mouse move events.
set mousemoveevent

" Set manual fold method.
set foldmethod=manual

" Enable folding based on the 'foldmethod'.
set foldenable

" Reset cursor settings (possibly by mistake or intentionally empty).
set guicursor=

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
Plug 'williamboman/mason.nvim'
" TypeScript server
Plug 'williamboman/mason.nvim', { 'do': ':MasonInstall tsserver' }
" Python language server
Plug 'williamboman/mason.nvim', { 'do': ':MasonInstall pylsp' }
" Rust Analyzer
Plug 'williamboman/mason.nvim', { 'do': ':MasonInstall rust-analyzer' }
Plug 'junegunn/fzf.vim'
Plug 'jbyuki/instant.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
Plug 'wbthomason/packer.nvim'
Plug 'ap/vim-css-color'
Plug 'aduros/ai.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'SmiteshP/nvim-navic'
Plug 'nvim-lua/plenary.nvim'
Plug 'mcchrish/zenbones.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'MunifTanjim/nui.nvim'
Plug 'Bryley/neoai.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'voldikss/vim-floaterm'
" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'rust-lang/rust.vim'
Plug 'epwalsh/obsidian.nvim'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

let g:netrw_sort_by="exten"                 "this chooses the style of sorting  


let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let mapleader = ","
let g:ycm_semantic_triggers = { 'c': [ 're!\w{2}' ] }
" let g:copilot_node_command = "~/.nvm/versions/node/v16.18.0/bin/node"
let g:copilot_no_tab_map = v:true
let g:vim_json_syntax_conceal = 0
let g:instant_username = "kn"
let g:copilot_enabled = v:true

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap gp :silent %!prettier --stdin-filepath %<CR>
nnoremap <C-p> :Telescope buffers<CR>
nnoremap <C-l> :Telescope live_grep<CR>
nnoremap <C-t> :Telescope help_tags<CR>
nnoremap <F2> :let @+=expand('%:p')<CR>
" Toggle the floaterm
nnoremap <F7> :FloatermToggle<CR>
tnoremap <F7> <C-\><C-n>:FloatermToggle<CR>
" New terminal
nnoremap <F8> :FloatermNew<CR>
" Navigate between multiple terminal windows
nnoremap <F9> :FloatermPrev<CR>
nnoremap <F10> :FloatermNext<CR>



vnoremap <leader>mcs <Plug>nvim-magic-append-completion
vnoremap <leader>mss <Plug>nvim-magic-suggest-alteration

imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" nmap <silent> gd <Plug>(lua vim.lsp.buf.declaration())
" nmap <silent> gD <Plug>(lua vim.lsp.buf.definition())
" nmap <silent> gr <Plug>(lua vim.lsp.buf.references())

" require plugin configs
lua require('kishorenewton')

command! -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --ignore-vcs '.shellescape(<q-args>), 1, fzf#vim#with_preview(), 0)
