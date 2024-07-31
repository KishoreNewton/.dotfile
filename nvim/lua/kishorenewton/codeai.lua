require('packer').startup(function()
    -- ... potentially other plugins ...

    use({
      "jackMort/ChatGPT.nvim",
        config = function()
          require("chatgpt").setup({})
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })

    -- ... potentially other plugins ...
end)

