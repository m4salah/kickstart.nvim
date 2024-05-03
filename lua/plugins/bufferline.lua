return {
  'akinsho/bufferline.nvim',
  branch = 'main',
  commit = 'f6f00d9ac1a51483ac78418f9e63126119a70709',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup {}
  end,
}
