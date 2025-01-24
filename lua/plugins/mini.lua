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
    -- require('mini.pairs').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-sessions.md
    require('mini.sessions').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md
    -- require('mini.starter').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
    require('mini.tabline').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
    require('mini.bracketed').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-diff.md
    require('mini.diff').setup()

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
    require('mini.cursorword').setup()

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

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
    require('mini.files').setup {
      mappings = {
        go_in_plus = '<CR>', -- open file & close filetree
      },
    }
    vim.keymap.set('n', '<C-n>', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      MiniFiles.open(path)
      MiniFiles.reveal_cwd()
    end, { desc = 'Open Mini Files' })

    -- # Create mapping to show/hide dot-files ~
    --
    -- Create an autocommand for `MiniFilesBufferCreate` event which calls
    -- |MiniFiles.refresh()| with explicit `content.filter` functions: >lua
    local show_dotfiles = true

    local filter_show = function(fs_entry)
      return true
    end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh { content = { filter = new_filter } }
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
      end,
    })

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
      end,
    })

    -- Toggle preview
    local toggle_preview = function()
      MiniFiles.config.windows.preview = not MiniFiles.config.windows.preview
      MiniFiles.refresh {}
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'gp', toggle_preview, { buffer = buf_id })
      end,
    })
  end,
}
