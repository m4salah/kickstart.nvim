local opts = { noremap = true, silent = true, desc = 'generate neogen' }
vim.api.nvim_set_keymap('n', '<Leader>nf', ":lua require('neogen').generate()<CR>", opts)
return {
  'danymat/neogen',
  config = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
