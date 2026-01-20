require('specs').setup({
    show_jumps = true,
    min_jump = 1,
    track_vertical = true,
    track_horizontal = true,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 5, -- time increments used for fade/resize effects
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        winhl = "PMenu",
        fader = require('specs').exponential_fader,  -- Using exponential fading effect
        resizer = require('specs').slide_resizer     -- Using slide resizing effect
    },
    click_to_move = true,
    move_to_insert = true,
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
})

