-- Cursor Trail Animation Plugin for Neovim
-- A lightweight cursor animation plugin with minimal resource usage

local M = {}
local api = vim.api
local fn = vim.fn

-- Configuration
local config = {
  enabled = true,
  character = '●',  -- Trail character (can be changed to ▪, ◆, ✦, ⬤, etc.)
  length = 5,        -- Trail length
  fade_time = 150,   -- Fade duration in milliseconds
  highlight_groups = {
    'CursorTrail1',
    'CursorTrail2', 
    'CursorTrail3',
    'CursorTrail4',
    'CursorTrail5',
  },
  update_interval = 30,  -- Update interval in milliseconds
}

-- State
local trail_marks = {}
local namespace = api.nvim_create_namespace('cursor_trail')
local timer = nil
local last_pos = {0, 0}
local trail_positions = {}

-- Setup highlight groups with fading effect
local function setup_highlights()
  -- Create gradient from bright to dim
  api.nvim_set_hl(0, 'CursorTrail1', { fg = '#FF6B6B', bold = true })
  api.nvim_set_hl(0, 'CursorTrail2', { fg = '#CC5555' })
  api.nvim_set_hl(0, 'CursorTrail3', { fg = '#994444' })
  api.nvim_set_hl(0, 'CursorTrail4', { fg = '#663333' })
  api.nvim_set_hl(0, 'CursorTrail5', { fg = '#332222' })
end

-- Clear all trail marks
local function clear_trail()
  api.nvim_buf_clear_namespace(0, namespace, 0, -1)
  trail_marks = {}
  trail_positions = {}
end

-- Get current cursor position
local function get_cursor_pos()
  local pos = api.nvim_win_get_cursor(0)
  return {pos[1] - 1, pos[2]}  -- Convert to 0-indexed
end

-- Check if position is valid and visible
local function is_valid_position(bufnr, line, col)
  local line_count = api.nvim_buf_line_count(bufnr)
  if line < 0 or line >= line_count then
    return false
  end
  
  local line_text = api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1]
  if not line_text then
    return false
  end
  
  -- Allow position at end of line for trail effect
  return col >= 0 and col <= #line_text
end

-- Update trail animation
local function update_trail()
  if not config.enabled then
    return
  end
  
  local bufnr = api.nvim_get_current_buf()
  local current_pos = get_cursor_pos()
  
  -- Check if cursor moved
  if current_pos[1] == last_pos[1] and current_pos[2] == last_pos[2] then
    return
  end
  
  -- Add new position to trail
  table.insert(trail_positions, 1, {
    line = last_pos[1],
    col = last_pos[2],
    time = vim.loop.now()
  })
  
  -- Limit trail length
  while #trail_positions > config.length do
    table.remove(trail_positions)
  end
  
  -- Clear old marks
  api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  
  -- Draw trail
  for i, pos in ipairs(trail_positions) do
    if is_valid_position(bufnr, pos.line, pos.col) then
      local hl_group = config.highlight_groups[math.min(i, #config.highlight_groups)]
      
      -- Use extmark with virtual text for the trail
      local ok = pcall(api.nvim_buf_set_extmark, bufnr, namespace, pos.line, pos.col, {
        virt_text = {{config.character, hl_group}},
        virt_text_pos = 'overlay',
        priority = 100 - i,  -- Higher priority for newer marks
        ephemeral = true,    -- Don't save with session
      })
    end
  end
  
  last_pos = current_pos
end

-- Start animation timer
local function start_timer()
  if timer then
    timer:stop()
    timer:close()
  end
  
  timer = vim.loop.new_timer()
  timer:start(0, config.update_interval, vim.schedule_wrap(function()
    local ok, err = pcall(update_trail)
    if not ok then
      -- Silently handle errors to prevent spam
    end
  end))
end

-- Stop animation timer
local function stop_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

-- Initialize the plugin
function M.setup(user_config)
  -- Merge user config
  if user_config then
    config = vim.tbl_deep_extend('force', config, user_config)
  end
  
  setup_highlights()
  
  -- Create autocommands
  local group = api.nvim_create_augroup('CursorTrail', { clear = true })
  
  -- Start animation when entering a buffer
  api.nvim_create_autocmd({'BufEnter', 'WinEnter'}, {
    group = group,
    callback = function()
      if config.enabled then
        clear_trail()
        last_pos = get_cursor_pos()
        start_timer()
      end
    end
  })
  
  -- Stop animation when leaving
  api.nvim_create_autocmd({'BufLeave', 'WinLeave'}, {
    group = group,
    callback = function()
      stop_timer()
      clear_trail()
    end
  })
  
  -- Clear trail on mode change
  api.nvim_create_autocmd('ModeChanged', {
    group = group,
    callback = function()
      if config.enabled then
        clear_trail()
        trail_positions = {}
      end
    end
  })
  
  -- Handle buffer modifications
  api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
    group = group,
    callback = function()
      -- Clear trail on text change to prevent artifacts
      trail_positions = {}
    end
  })
end

-- Toggle animation on/off
function M.toggle()
  config.enabled = not config.enabled
  if config.enabled then
    start_timer()
    print("Cursor trail enabled")
  else
    stop_timer()
    clear_trail()
    print("Cursor trail disabled")
  end
end

-- Update configuration
function M.configure(new_config)
  config = vim.tbl_deep_extend('force', config, new_config)
  setup_highlights()
  if config.enabled then
    clear_trail()
    start_timer()
  end
end

-- Cleanup function
function M.cleanup()
  stop_timer()
  clear_trail()
  config.enabled = false
end

return M
