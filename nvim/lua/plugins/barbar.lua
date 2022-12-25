require'bufferline'.setup{
  icons = false,
  animation = false,

  maximum_padding = 0,

  closable = false,
  icon_separator_active = '',
  icon_separator_inactive = ''
}

-- ensure tabs begin with the shown buffer
local api = require('bufferline.api')
local nvim_tree_events = require('nvim-tree.events')

nvim_tree_events.subscribe('TreeOpen', function()
  api.set_offset( require('nvim-tree.view').View.width )
end)

nvim_tree_events.subscribe('Resize', function()
  api.set_offset( require('nvim-tree.view').View.width )
end)

nvim_tree_events.subscribe('TreeClose', function()
  api.set_offset(0)
end)

-- keybindings
local map = vim.keymap.set
local input = vim.api.nvim_input

map({'n', 'i'}, '<A-l>', '<Cmd>BufferNext<CR>')
map({'n', 'i'}, '<A-h>', '<Cmd>BufferPrevious<CR>')
map('n', '<A-c>', '<Cmd>BufferClose<CR>')

