-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
        disable_netrw = true,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        view = {
          relativenumber = true,
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = 'editor',
              border = 'rounded',
              width = 50,
              height = 50,
              row = 1,
              col = 1,
            },
          },
        },
      }

      -- leader n to toggle nvim tree
      vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
    end,
  },
}
