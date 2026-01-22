" Vim color file
" Maintainer: Kishore Newton <contact+vimneovim@kishorenewton.com>
" Last Change: 2024-09-01
" License: MIT
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "hackertheme"
" Hacker Theme Color Scheme 
"
" Popup Menu / Autocomplete
hi Visual term=none cterm=none guibg=#FFFFFF  guifg=#000000
highlight Pmenu guibg=#0a0a0f guifg=#e0e0e0
highlight PmenuSel guibg=#00ff00 guifg=#000000 gui=bold
highlight PmenuSbar guibg=#151520
highlight PmenuThumb guibg=#00ff00

" Float Window
highlight NormalFloat guibg=#0a0a0f guifg=#e0e0e0
highlight FloatBorder guifg=#00ff00 guibg=#0a0a0f
" General Text
highlight Normal guifg=#00ff00
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
highlight netrwDir guifg=#4FC1FF 
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
hi @lsp.type.variable guifg=#00ff00
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

