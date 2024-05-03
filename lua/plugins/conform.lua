return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      --
      -- markdown
      markdown = { 'markdownlint' },

      -- protobuf files
      proto = { 'buf' },

      -- terraform
      terraform = { 'terraform_fmt' },

      -- terragrun
      hcl = { 'terragrunt_hclfmt' },

      -- toml
      toml = { 'taplo' },

      -- yaml
      yaml = { 'yamlls' },

      -- golang
      go = { 'goimports', 'gofmt', 'golines' },
      templ = { 'templ' },

      -- java/typescript prettier
      json = { 'prettierd', 'prettier' },
      htmldjango = { 'djlint' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },

      -- sql
      sql = { 'sql_formatter' },
    },
  },
}
