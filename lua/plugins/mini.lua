return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- icons
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
    require('mini.indentscope').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
    require('mini.pairs').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-sessions.md
    require('mini.sessions').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
    require('mini.starter').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
    require('mini.tabline').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
    require('mini.bracketed').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-diff.md
    require('mini.diff').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
    require('mini.cursorword').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
    require('mini.files').setup()
    vim.keymap.set('n', '<C-n>', '<CMD>lua MiniFiles.open()<CR>')

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'

    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
