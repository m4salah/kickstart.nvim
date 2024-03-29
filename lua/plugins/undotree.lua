return { -- undo tree
  'mbbill/undotree',
  config = function()
    -- leader u to toggle undo tree
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end,
}
