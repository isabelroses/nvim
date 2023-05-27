vim.g.barbar_auto_setup = false -- disable auto-setup
require'barbar'.setup {
  clickable = true,
  -- Enable highlighting visible buffers
  highlight_visible = false,

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = false,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
  },

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = true,
    undotree = {text = 'undotree'},
  },

 }
