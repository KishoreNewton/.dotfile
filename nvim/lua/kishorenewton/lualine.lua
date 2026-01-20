-- Eviline config for lualine (Updated for 2025)
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    -- Add global statusline option (recommended for 2025)
    globalstatus = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {
      {
        'filename',
        file_status = true,  -- still display file status if needed
        path = 2,            -- set to 1 for relative path or 2 for absolute path
        shorting_target = 40 -- optionally shorten the path
      }
    },
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  file_status = true,  -- displays file status (e.g., read-only)
  path = 2,            -- 0 = just filename, 1 = relative path, 2 = absolute path
  shorting_target = 40, -- Shortens path to leave room on the statusline
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' }
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  -- FIXED: Changed from 'nvim_diagnostic' to 'nvim_lsp' (modern source name)
  sources = { 'nvim_lsp' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },      -- FIXED: Changed from color_error
    warn = { fg = colors.yellow },    -- FIXED: Changed from color_warn
    info = { fg = colors.cyan },      -- FIXED: Changed from color_info
    hint = { fg = colors.blue },      -- ADDED: hint level
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name (COMPLETELY FIXED for 2025)
  function()
    local msg = 'No Active Lsp'
    -- FIXED: Using vim.bo instead of deprecated vim.api.nvim_buf_get_option
    local buf_ft = vim.bo.filetype
    -- FIXED: Using vim.lsp.get_clients instead of deprecated vim.lsp.get_active_clients
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    
    if next(clients) == nil then
      return msg
    end
    
    -- Collect names of attached LSP clients
    local client_names = {}
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        table.insert(client_names, client.name)
      end
    end
    
    -- Return concatenated names or default message
    if #client_names > 0 then
      return table.concat(client_names, ', ')
    end
    
    return msg
  end,
  icon = '  LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = ' ',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified is really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' }, -- Fixed the modified symbol
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Mode map for reference (not used in this config but useful to have)
local mode_map = {
  ['n']  = 'NORMAL',
  ['no'] = 'N-OPER',
  ['i']  = 'INSERT',
  ['ic'] = 'I-COMP',
  ['ix'] = 'I-XCOMP',
  ['v']  = 'VISUAL',
  ['V']  = 'V-LINE',
  [''] = 'V-BLOCK', -- Ctrl-V
  ['s']  = 'SELECT',
  ['S']  = 'S-LINE',
  [''] = 'S-BLOCK', -- Ctrl-S
  ['c']  = 'COMMAND',
  ['cv'] = 'CMDLINE V',
  ['ce'] = 'EX',
  ['R']  = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!']  = 'SHELL',
  ['t']  = 'TERMINAL'
}

-- Alternative helper function for getting LSP info (bonus utility)
function GetLspInfo()
  -- Using modern API
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end
  
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return " " .. table.concat(names, ", ")
end

-- Now don't forget to initialize lualine
lualine.setup(config)
