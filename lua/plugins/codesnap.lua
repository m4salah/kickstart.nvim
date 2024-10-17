return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    require('codesnap').setup {
      bg_padding = 0,
    }
  end,
}
