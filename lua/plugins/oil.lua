return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 80,
        max_height = 60,
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['q'] = 'actions.close',
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
  end,
}
