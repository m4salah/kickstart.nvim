return {
  { -- nvim tree
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      }

      -- leader n to toggle nvim tree
      vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)

      -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#go-to-last-used-hidden-buffer-when-deleting-a-buffer
      vim.api.nvim_create_autocmd('BufEnter', {
        nested = true,
        callback = function()
          local api = require 'nvim-tree.api'

          -- Only 1 window with nvim-tree left: we probably closed a file buffer
          if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
            -- Required to let the close event complete. An error is thrown without this.
            vim.defer_fn(function()
              -- close nvim-tree: will go to the last hidden buffer used before closing
              api.tree.toggle { find_file = true, focus = true }
              -- re-open nivm-tree
              api.tree.toggle { find_file = true, focus = true }
              -- nvim-tree is still the active window. Go to the previous window.
              vim.cmd 'wincmd p'
            end, 0)
          end
        end,
      })
    end,
  },
}
