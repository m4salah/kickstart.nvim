return { -- Linting
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- install required lint by mason
    local ensure_installed = {
      'eslint_d',
      'tflint',
      'markdownlint',
      'buf',
    }
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      terraform = { 'tflint' },
    }
    local eslint = lint.linters.eslint_d

    eslint.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    lint.linters.eslint_d = require('lint.util').wrap(lint.linters.eslint_d, function(diagnostic)
      -- try to ignore "No ESLint configuration found" error
      -- if diagnostic.message:find("Error: No ESLint configuration found") then -- old version
      -- update: 20240814, following is working
      if diagnostic.message:find 'Error: Could not find config file' then
        return nil
      end
      return diagnostic
    end)

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint(nil, {
          ignore_errors = true
        })
      end,
    })
  end,
}
