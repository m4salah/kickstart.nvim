-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Helper functions to map keys in different modes
local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- in visual mode move the current selected up or down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- when scroll half page keep the cursor in the middle
keymap.set('n', '<C-d>', '<C-d>zz', opts)
keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- leader p for pasting over selected item but don't override the clipboard
keymap.set('x', '<leader>p', '"_dp', opts)

-- buffer navigating
keymap.set('n', '<Tab>', vim.cmd.bn, { desc = '[N]ext buffer' })
keymap.set('n', '<S-Tab>', vim.cmd.bp, { desc = '[P]revious buffer' })
keymap.set('n', '<leader>x', vim.cmd.bd, { desc = 'E[X]it/Kill buffer' })
keymap.set('n', '<leader><leader>', '<c-^>', { desc = 'Switch between recent two buffers' })

-- split keys
keymap.set('n', '<leader>v', vim.cmd.vsplit, { desc = '[V]ertical Split' })
keymap.set('n', '<leader>h', vim.cmd.split, { desc = '[H]orizontal Split' })

-- set jj to esc
keymap.set('i', 'jj', '<Esc>', opts)

-- save/quit keys
keymap.set('n', '<leader>w', vim.cmd.w, opts)
keymap.set('n', '<leader>q', vim.cmd.q, opts)

-- L to the end of the line
keymap.set({ 'n', 'v' }, 'L', '$', opts)

-- H to the begining of the line
keymap.set({ 'n', 'v' }, 'H', '^', opts)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal stuff
keymap.set('n', '<leader>ts', function()
  vim.cmd 'belowright 20split'
  vim.cmd 'set winfixheight'
  vim.cmd 'term'
  vim.cmd 'startinsert'
end)
