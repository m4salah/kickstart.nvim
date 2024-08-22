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
      -- use mini icons
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()

      -- setup nvim tree
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
        },
      }

      -- leader n to toggle nvim tree
      vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
    end,
  },
}
