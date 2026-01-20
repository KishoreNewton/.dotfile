local use = require('packer').use
require('packer').startup(function()
  -- Note: nvim-lspconfig is no longer needed with Neovim 0.11+
  -- use 'neovim/nvim-lspconfig' -- REMOVED: Using native vim.lsp.config instead
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets' -- Added: snippet collection
  use "lunarvim/synthwave84.nvim"
  use 'SmiteshP/nvim-navic' -- Added: for breadcrumbs support
end)
-- vim.cmd[[colorscheme synthwave84]]

-- ==============================================================================
-- Modern Diagnostic Configuration (2025 Standards)
-- ==============================================================================
local opts = { noremap=true, silent=true }

-- Updated keymaps using vim.diagnostic.jump (new in 0.11)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Modern diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = '●',
    spacing = 4,
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source or diagnostic.code)
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "🚫",
      [vim.diagnostic.severity.WARN] = "🌀",
      [vim.diagnostic.severity.INFO] = "💡",
      [vim.diagnostic.severity.HINT] = "🔮",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Improved highlight function using new API
local function set_diagnostic_highlights(error_color, warn_color, info_color, hint_color)
    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = error_color })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = warn_color })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = info_color })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = hint_color })
end

-- Initialize with default colors
set_diagnostic_highlights("#FF5F5F", "#f5ed05", "#80c3d9", "#e3e3e3")

-- Toggle diagnostics display (updated for 0.11+)
local diagnostics_visible = true
function ToggleDiagnostics()
    diagnostics_visible = not diagnostics_visible
    vim.diagnostic.enable(diagnostics_visible)
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

-- ==============================================================================
-- Native LSP Configuration (Neovim 0.11+ - No lspconfig needed!)
-- ==============================================================================

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Add folding capabilities for Neovim 0.11+
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Enhanced on_attach function (FIXED: All deprecated APIs updated)
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    
    -- Attach navic for breadcrumbs
    local ok, navic = pcall(require, "nvim-navic")
    if ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
    
    -- Configure hover with rounded borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { 
            focusable = false,
            border = "rounded"
        }
    )
    
    -- Signature help with rounded borders
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "rounded"
        }
    )
    
    -- Mappings (updated for modern standards)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
    vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() 
        vim.lsp.buf.format { async = true } 
    end, bufopts)
    
    -- Enable inlay hints if available (Neovim 0.10+)
    -- FIXED: Using vim.lsp.inlay_hint.enable() with buffer option
    if vim.lsp.inlay_hint and client.supports_method then
        if client.supports_method('textDocument/inlayHint') then
            vim.keymap.set('n', '<space>ih', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, bufopts)
        end
    end
end

-- ==============================================================================
-- FOR BACKWARD COMPATIBILITY - Using lspconfig if native API not available
-- ==============================================================================
-- Check if we have native vim.lsp.config (Neovim 0.11+)
if vim.lsp.config then
    -- ==============================================================================
    -- Native Language Server Configurations (Neovim 0.11+ vim.lsp.config)
    -- ==============================================================================

    -- HTML Server
    vim.lsp.config('html', {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html', 'templ' },
        root_markers = { '.git', 'package.json' },
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
                css = true,
                javascript = true
            },
            provideFormatter = true
        }
    })

    -- CSS Server
    vim.lsp.config('cssls', {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { '.git', 'package.json' },
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- Grammarly
    vim.lsp.config('grammarly', {
        cmd = { 'grammarly-languageserver', '--stdio' },
        filetypes = { 'markdown', 'text' },
        root_markers = { '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- C/C++ Clangd
    vim.lsp.config('clangd', {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
    })

    -- YAML with schema support
    vim.lsp.config('yamlls', {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_markers = { '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                },
            },
        },
    })

    -- Rust Analyzer (Updated for 2025)
    vim.lsp.config('rust_analyzer', {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
                procMacro = {
                    enable = true,
                    attributes = {
                        enable = true,
                    },
                },
                diagnostics = {
                    enable = true,
                    experimental = {
                        enable = true,
                    },
                },
                inlayHints = {
                    bindingModeHints = {
                        enable = false,
                    },
                    chainingHints = {
                        enable = true,
                    },
                    closingBraceHints = {
                        enable = true,
                        minLines = 25,
                    },
                    closureReturnTypeHints = {
                        enable = "never",
                    },
                    lifetimeElisionHints = {
                        enable = "never",
                        useParameterNames = false,
                    },
                    maxLength = 25,
                    parameterHints = {
                        enable = true,
                    },
                    renderColons = true,
                    typeHints = {
                        enable = true,
                        hideClosureInitialization = false,
                        hideNamedConstructor = false,
                    },
                },
            },
        },
    })

    -- Python (Pyright)
    vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "standard",
                },
            },
        },
    })

    -- TypeScript/JavaScript (ts_ls - the modern name)
    vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
            hostInfo = "neovim"
        },
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            }
        }
    })

    -- Enable all configured language servers
    vim.lsp.enable('html')
    vim.lsp.enable('cssls')
    vim.lsp.enable('grammarly')
    vim.lsp.enable('clangd')
    vim.lsp.enable('yamlls')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('pyright')
    vim.lsp.enable('ts_ls')

else
    -- Fallback to lspconfig if native API not available
    -- You'll need to add 'neovim/nvim-lspconfig' back to packer if using older Neovim
    local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
    if has_lspconfig then
        -- HTML & CSS servers
        local servers = { 'html', 'grammarly', 'cssls' }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end

        -- C/C++ with enhanced settings
        lspconfig.clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
            },
        }

        -- YAML with schema support
        lspconfig.yamlls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemas = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                    },
                },
            },
        }

        -- Rust Analyzer
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                        enable = true,
                        attributes = {
                            enable = true,
                        },
                    },
                    diagnostics = {
                        enable = true,
                        experimental = {
                            enable = true,
                        },
                    },
                    inlayHints = {
                        bindingModeHints = {
                            enable = false,
                        },
                        chainingHints = {
                            enable = true,
                        },
                        closingBraceHints = {
                            enable = true,
                            minLines = 25,
                        },
                        closureReturnTypeHints = {
                            enable = "never",
                        },
                        lifetimeElisionHints = {
                            enable = "never",
                            useParameterNames = false,
                        },
                        maxLength = 25,
                        parameterHints = {
                            enable = true,
                        },
                        renderColons = true,
                        typeHints = {
                            enable = true,
                            hideClosureInitialization = false,
                            hideNamedConstructor = false,
                        },
                    },
                },
            },
        }

        -- Python (Pyright)
        lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "standard",
                    },
                },
            },
        }

        -- TypeScript/JavaScript
        lspconfig.ts_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                hostInfo = "neovim"
            },
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                }
            }
        }
    else
        print("Warning: nvim-lspconfig not found and native vim.lsp.config not available!")
        print("Please add 'neovim/nvim-lspconfig' to your packer config or upgrade to Neovim 0.11+")
    end
end

-- ==============================================================================
-- Helper function to check LSP status (FIXED: Using vim.lsp.get_clients)
-- ==============================================================================
function LspStatus()
    -- FIXED: vim.lsp.get_active_clients() is deprecated, use vim.lsp.get_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return "No LSP"
    end
    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    return "LSP: " .. table.concat(names, ", ")
end

-- ==============================================================================
-- nvim-cmp Configuration (Enhanced for 2025)
-- ==============================================================================

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require 'luasnip'
local cmp = require 'cmp'

-- Modern icons for completion items
local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = 'rounded',
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = 'rounded',
        }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                cmdline = "[Cmd]",
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ 
            behavior = cmp.ConfirmBehavior.Replace,
            select = true 
        }),
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
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 750 },
        { name = 'buffer', priority = 500 },
        { name = 'path', priority = 250 },
    }),
    experimental = {
        ghost_text = true, -- Show preview of completion
    },
}

-- Setup for command line
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- ==============================================================================
-- Auto-formatting Configuration
-- ==============================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.css", "*.scss", "*.html" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- ==============================================================================
-- Additional deprecated API fixes
-- ==============================================================================
-- If you have any custom functions using deprecated APIs, here are the replacements:
-- OLD: vim.lsp.get_active_clients() → NEW: vim.lsp.get_clients()
-- OLD: vim.lsp.buf_get_clients() → NEW: vim.lsp.get_clients({ bufnr = bufnr })
-- OLD: vim.diagnostic.goto_next() → NEW: vim.diagnostic.jump({ count = 1 })
-- OLD: vim.diagnostic.goto_prev() → NEW: vim.diagnostic.jump({ count = -1 })
-- OLD: vim.lsp.buf_request_sync() → NEW: vim.lsp.buf.request_sync()
-- OLD: vim.api.nvim_buf_set_option() → NEW: vim.bo[bufnr].option = value
-- OLD: vim.api.nvim_set_option() → NEW: vim.o.option = value
