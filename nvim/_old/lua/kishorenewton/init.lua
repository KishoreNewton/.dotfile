-- require('kishorenewton.telescope')
-- require('kishorenewton.lspconfig')
require('kishorenewton.cmp')
require('kishorenewton.specs')
-- require('kishorenewton.ai')
-- require('kishorenewton.codeai')
require('kishorenewton.lualine')
-- require('kishorenewton.bufferline')
require('kishorenewton.mason')
require('kishorenewton.obsidian')
require('kishorenewton.pdf').setup()
require('kishorenewton.gitsign')


vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] = nil
    end,
})
