local M = {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
}

function M.config()
  require('toggleterm').setup {
    -- size = 20,
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.25
      end
    end,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[\\]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = 'vertical',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    float_opts = {
      border = 'rounded',
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
    winbar = {
      enabled = false,
      -- name_formatter = function(term) --  term: Terminal
      --   return term.count
      -- end,
    },
  }
  -- vim.cmd [[
  -- augroup terminal_setup | au!
  -- autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  -- autocmd TermEnter * startinsert!
  -- augroup end
  -- ]]
  --
  -- vim.api.nvim_create_autocmd({ 'TermEnter' }, {
  --   pattern = { '*' },
  --   callback = function()
  --     vim.cmd 'startinsert'
  --   end,
  -- })

  local opts = { noremap = true, silent = true }
  function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
end

return M
