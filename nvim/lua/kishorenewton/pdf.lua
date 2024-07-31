local api = vim.api
local fn = vim.fn

-- Create a new namespace for PDF highlighting
local pdf_ns = api.nvim_create_namespace('pdf_viewer')

local M = {}

-- Function to view PDF content
local function view_pdf(file_path)
  -- Check if the file is readable
  if fn.filereadable(file_path) == 0 then
    print("Error: File not readable")
    return
  end

  -- Use pdftotext to convert PDF to text
  local pdf_content = fn.system({'pdftotext', '-layout', '-nopgbrk', file_path, '-'})
  
  -- Split the content into lines
  local lines = vim.split(pdf_content, '\n')

  -- Clear the current buffer and set its content
  api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Set buffer options
  api.nvim_buf_set_option(0, 'modifiable', false)
  api.nvim_buf_set_option(0, 'filetype', 'pdf_view')

  -- Add some basic syntax highlighting
  api.nvim_buf_add_highlight(0, pdf_ns, 'Title', 0, 0, -1)
  
  for i, line in ipairs(lines) do
    if line:match('^%s*Page%s+%d+') then
      api.nvim_buf_add_highlight(0, pdf_ns, 'Special', i - 1, 0, -1)
    end
  end
end

-- Function to set up autocommands
local function setup_autocmds()
  local group = api.nvim_create_augroup("PDFViewer", { clear = true })
  api.nvim_create_autocmd({"BufReadCmd"}, {
    group = group,
    pattern = "*.pdf",
    callback = function()
      local file_path = api.nvim_buf_get_name(0)
      view_pdf(file_path)
    end,
  })
end

-- Setup function to be called in init.lua
function M.setup()
  setup_autocmds()
end

return M
