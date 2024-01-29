syntax on
syntax enable
filetype plugin indent on
" filetype plugin on

set autowriteall
set nowrap
set scrolloff=0
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
set updatetime=2000
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
set mousemoveevent
set guicursor=

" Hacker Theme Color Scheme - Improved Readability
" Popup Menu
hi Visual term=none cterm=none guibg=#FFFFFF  guifg=#000000

highlight Pmenu guibg=#3C3C60 guifg=#FFFFFF
highlight PmenuSel guibg=#5C5C80 guifg=#FFFFFF

" General Text
highlight Normal guifg=#53cd38
highlight Comment guifg=#D1D1D1 gui=italic
highlight String guifg=#FFF066

" Syntax Elements
highlight Number guifg=#EFF0EB gui=bold
highlight Boolean guifg=#86E3CE
highlight Float guifg=#EFF0EB gui=italic
highlight Function guifg=#9DE0AD
highlight Conditional guifg=#CFF4D2 gui=italic
highlight Repeat guifg=#CCABD8 gui=italic
highlight Label guifg=#D3E7EE gui=italic
highlight Operator guifg=#FFDCA2 gui=bold
highlight Keyword guifg=#A9D0F5 gui=italic
highlight Identifier guifg=#FFE5B4
highlight Exception guifg=#AAB6FB gui=bold
highlight StorageClass guifg=#FAA7B8 gui=italic
highlight Structure guifg=#FB7BBE gui=italic
highlight Special guifg=#FF9CDA gui=italic
highlight SpecialComment guifg=#9B9B9B gui=bold

" Line Numbers and Status Bar
highlight LineNr guifg=#FDE4E3
highlight StatusLine guifg=#FDE4E3 guibg=#000000 ctermfg=NONE ctermbg=NONE cterm=italic
highlight StatusLineNC guifg=#FF5733

" Tab Line
highlight TabLine guibg=#355C7D ctermfg=NONE ctermbg=NONE cterm=italic
highlight TabLineSel guifg=#05386B guibg=#5CDB95 gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
highlight TabLineFill guifg=#111111 guibg=#000000 ctermfg=254 ctermbg=238

" LSP Colors
" hi @lsp.type.function guifg=Yellow
" hi @lsp.type.variable.lua guifg=Green
hi @lsp.type.variable guifg=#32CD32
" hi @lsp.mod.deprecated gui=strikethrough
" hi @lsp.typemod.function.async guifg=#FF0000

" Spell Checking
hi SpellBad ctermfg=black
hi SpellCap ctermfg=black
hi SpellLocal ctermfg=black
hi SpellRare ctermfg=black
hi SpellRareUnderlined ctermfg=black cterm=underline
hi SpellLocalUnderlined ctermfg=black cterm=underline
hi SpellCapUnderlined ctermfg=black cterm=underline
hi SpellBadUnderlined ctermfg=black cterm=underline
hi NonText guifg=#C9BBC8 gui=bold

" Copilot Suggestion
highlight CopilotSuggestion guifg=#d1001c ctermfg=8

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
Plug 'junegunn/fzf.vim'
Plug 'jbyuki/instant.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'prettier/vim-prettier'
Plug 'edluffy/specs.nvim'
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

" autocmd BufWritePost * silent! execute '!git add % && git commit -m %' "
" autocmd BufWritePost *.rs silent! execute '!rustfmt %'"
autocmd BufWritePost *.py silent! execute '!black %'
autocmd BufWritePre *.js lua vim.lsp.buf.format { async = true } 
autocmd BufWritePre *.ts lua vim.lsp.buf.format { async = true } 
autocmd BufWritePre *.rs lua vim.lsp.buf.format { async = true } 
autocmd BufWritePre *.css lua vim.lsp.buf.format { async = true } 
" autocmd BufWritePre *.py lua vim.lsp.buf.format { async = true } "
autocmd BufWritePre *.html lua vim.lsp.buf.format { async = true } 

lua << EOF
require('neoai').setup{
    -- Below are the default options, feel free to override what you would like changed
    ui = {
        output_popup_text = "NeoAI",
        input_popup_text = "Prompt",
        width = 30,      -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
        submit = "<C-g>", -- Key binding to submit the prompt
    },
    models = {
        {
            name = "openai",
            model = "gpt-4-0613",
            params = nil,
        },
    },
    register_output = {
        ["g"] = function(output)
            return output
        end,
        ["c"] = require("neoai.utils").extract_code_snippets,
    },
    inject = {
        cutoff_width = 75,
    },
    prompts = {
        context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
                .. "messages. Here is the code/text that I want to refer "
                .. "to in our upcoming conversations:\n\n"
                .. context
        end,
    },
    mappings = {
        ["select_up"] = "<C-k>",
        ["select_down"] = "<C-j>",
    },
    open_api_key_env = "OPENAI_API_KEY",
    shortcuts = {
        {
            name = "textify",
            key = "<leader>as",
            desc = "fix text with AI",
            use_context = true,
            prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
            modes = { "v" },
            strip_function = nil,
        },
        {
            name = "gitcommit",
            key = "<leader>ag",
            desc = "generate git commit message",
            use_context = false,
            prompt = function ()
                return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
            end,
            modes = { "n" },
            strip_function = nil,
        },
    },
}
EOF

