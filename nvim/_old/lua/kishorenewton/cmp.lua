local use = require('packer').use
require('packer').startup(function()
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "lunarvim/synthwave84.nvim"
end)
-- vim.cmd[[colorscheme synthwave84]]

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Function to set diagnostic highlight colors
local function set_diagnostic_highlights(error_color, warn_color, info_color, hint_color)
    vim.cmd(string.format("hi DiagnosticError guifg=%s", error_color))
    vim.cmd(string.format("hi DiagnosticWarn guifg=%s", warn_color))
    vim.cmd(string.format("hi DiagnosticInfo guifg=%s", info_color))
    vim.cmd(string.format("hi DiagnosticHint guifg=%s", hint_color))
end

-- Initialize with default colors
set_diagnostic_highlights("#FF5F5F", "#f5ed05", "#80c3d9", "#e3e3e3")

-- -- Define diagnostic signs
-- vim.fn.sign_define('DiagnosticSignError', { text = '✖', texthl = 'DiagnosticError' })
-- vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticWarn' })
-- vim.fn.sign_define('DiagnosticSignInfo', { text = 'ℹ', texthl = 'DiagnosticInfo' })
-- vim.fn.sign_define('DiagnosticSignHint', { text = '➤', texthl = 'DiagnosticHint' })

-- Define diagnostic signs
-- vim.fn.sign_define('DiagnosticSignError', { text = '🚫', texthl = 'DiagnosticError' })
-- vim.fn.sign_define('DiagnosticSignWarn', { text = '⚡', texthl = 'DiagnosticWarn' })
-- vim.fn.sign_define('DiagnosticSignInfo', { text = '💡', texthl = 'DiagnosticInfo' })
-- vim.fn.sign_define('DiagnosticSignHint', { text = '🌟', texthl = 'DiagnosticHint' })
-- Define diagnostic signs
vim.fn.sign_define('DiagnosticSignError', { text = '🚫', texthl = 'DiagnosticError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '🌀', texthl = 'DiagnosticWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '💡', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '🔮', texthl = 'DiagnosticHint' })


-- Toggle diagnostics display
local diagnostics_visible = true
function ToggleDiagnostics()
    diagnostics_visible = not diagnostics_visible
    if diagnostics_visible then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

-- Function to display a summary of diagnostics
function ShowDiagnosticsSummary()
    local diagnostics = vim.diagnostic.get()
    local summary = {}
    for _, diag in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diag.severity]
        summary[severity] = (summary[severity] or 0) + 1
    end
    for severity, count in pairs(summary) do
        print(string.format("%s: %d", severity, count))
    end
end

-- Autocommand to update diagnostic signs on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        set_diagnostic_highlights("#FF5F5F", "#FFAF00", "#5FD7FF", "#5FFF00")
    end,
})


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
 -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false }

)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr  }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 1000,
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local lspconfig = require('lspconfig')
local servers = { 'html', 'grammarly' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = 'double',
    })
  },
  view = {
    entries = 'native'
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({
      config = {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' },
        }
      }
    }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}

require'lspconfig'.yamlls.setup{}

local rust_analyzer_settings = {
  ["rust-analyzer"] = {
    assist = {
      importMergeBehavior = "last",
      importPrefix = "by_self",
    },
    cargo = {
      loadOutDirsFromCheck = true,
      runBuildScripts = true,
      allFeatures = true
    },
    procMacro = {
      enable = true,
    },
    checkOnSave = {
      command = "clippy",
    },
    diagnostics = {
      enable = true,
      disabled = {},
    },
    rustfmt = {
      overrideCommand = {
        "rustfmt",
        "--emit=stdout",
        "--edition=2021",
      },
    },
    hoverActions = {
      enable = true,
    },
    inlayHints = {
      enable = true,
      parameterHints = true,
      chainingHints = true,
      typeHints = true,
    },
    completion = {
      autoimport = {
        enable = true,
      },
    },
    joinLines = {
      joinElseIf = true,
      removeTrailingComma = true,
    },
    expandMacro = {
      defaultsToShowNavBar = true,
      defaultsToShowExpansions = true,
      procMacro = {
        enable = true,
      },
    },
    trace = {
      server = "verbose",
    },
    externalDocs = {
      openIn = "browser",
    },
  },
}

-- Enable rust-analyzer with the above settings
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = rust_analyzer_settings,
}

-- Pyright configuration
local pyright_settings = {
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "workspace",
      useLibraryCodeForTypes = true,
      typeCheckingMode = "basic", -- can be "off", "basic", or "strict"
    },
  },
  format = {
    provider = "black",
  },
  linters = {
    enabled = { "flake8" },
  },
}

-- Enable pyright with the above settings
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = pyright_settings,
}

local tsserver_settings = {
  documentFormatting = true, -- disable document formatting for tsserver (you can set this to true if you want it to format, but ensure you have a tsconfig.json with format settings)
  codeAction = {
    enable = true,
  },
}

local nginx_language_server_settings = {
  documentFormatting = true, -- disable document formatting for tsserver (you can set this to true if you want it to format, but ensure you have a tsconfig.json with format settings)
  codeAction = {
    enable = true,
  },
}

-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   flags = lsp_flags,
--   settings = tsserver_settings,
-- }

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = tsserver_settings,
}

lspconfig.nginx_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = nginx_language_server_settings,
}

vim.cmd [[autocmd BufWritePre *.js,*.ts,*.json,*.css,*.scss lua vim.lsp.buf.format()]]

