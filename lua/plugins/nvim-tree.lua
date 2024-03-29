return { -- nvim tree
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}

    -- leader n to toggle nvim tree
    vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
  end,
}