require('specs').setup{ 
    show_jumps  = true,
    min_jump = 1,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects 
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        winhl = "PMenu",
        fader = require('specs').exp_fader,
        resizer = require('specs').slide_resizer
    },
    click_to_move = true,
    move_to_insert = true,
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}
-- Press <C-b> to call specs!
vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("specs").show_specs()', { noremap = true, silent = true })

-- You can even bind it to search jumping and more, example:
vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })

-- Or maybe you do a lot of screen-casts and want to call attention to a specific line of code:
vim.api.nvim_set_keymap('n', '<leader>v', ':lua require("specs").show_specs({width = 97, winhl = "Search", delay_ms = 610, inc_ms = 21})<CR>', { noremap = true, silent = true })
