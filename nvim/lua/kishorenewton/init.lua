-- require('kishorenewton.telescope')
-- require('kishorenewton.lspconfig')
require('kishorenewton.cmp')
-- require('kishorenewton.ai')
-- require('kishorenewton.codeai')
require('kishorenewton.lualine')
-- require('kishorenewton.bufferline')
require('kishorenewton.mason')
require('kishorenewton.obsidian')
require('kishorenewton.pdf').setup()
require('kishorenewton.gitsign')

local cursor_trail = require('kishorenewton.cursor-trail')
cursor_trail.setup({
  enabled = true,
  character = '●',           -- Try: ▪, ◆, ✦, ⬤, ▸, ◉, ○, •
  length = 5,                -- Number of trail segments (1-10 recommended)
  fade_time = 150,           -- Fade duration in ms
  update_interval = 30,      -- Update frequency in ms (lower = smoother but more CPU)
  highlight_groups = {       -- Custom colors (from bright to dim)
    'CursorTrail1',
    'CursorTrail2',
    'CursorTrail3',
    'CursorTrail4',
    'CursorTrail5',
  }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] = nil
    end,
})
