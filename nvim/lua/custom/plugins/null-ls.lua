return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local lSsources = {
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          'javascript',
          'typescript',
          'typescriptreact',
          'javascriptreact',
          'css',
          'scss',
          'html',
          'json',
          'yaml',
          'markdown',
          'graphql',
          'md',
          'txt',
        },
        only_local = 'node_modules/.bin',
      },
      null_ls.builtins.formatting.stylua.with {
        filetypes = {
          'lua',
        },
        args = { '--indent-width', '2', '--indent-type', 'Spaces', '-' },
      },
      null_ls.builtins.diagnostics.stylelint.with {
        filetypes = {
          'css',
          'scss',
        },
      },
    }

    -- Testing

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    require('null-ls').setup {
      sources = lSsources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(client)
                  return client.name == 'null-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
