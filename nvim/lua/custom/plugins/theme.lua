return {
  -- 'navarasu/onedark.nvim',
  -- priority = 1000,
  -- config = function()
  --   require('onedark').setup {
  --     style = 'dark',
  --     highlights = {
  --       -- IlluminatedWord = { bg = "#B2D4FC" },
  --       -- IlluminatedCurWord = { bg = "#B2D4FC" },
  --       -- IlluminatedWordText = { bg = "#B2D4FC" },
  --       -- IlluminatedWordRead = { bg = "#B2D4FC" },
  --       -- IlluminatedWordWrite = { bg = "#B2D4FC" },
  --     },
  --   }
  --   vim.cmd.colorscheme 'onedark'
  -- end,

  -- "rose-pine/neovim",
  -- priority = 1000,
  -- config = function()
  --   require("rose-pine").setup({
  --     variant = "main",
  --     dark_variant = "main",
  --     disable_italics = true,
  --     dim_inactive_windows = false,
  --     extend_background_behind_borders = true,
  --   })
  --   vim.cmd.colorscheme("rose-pine")
  -- end,

  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
    })
    vim.cmd.colorscheme("catppuccin")
  end,
  -- {
  -- "AlexvZyl/nordic.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   require("nordic").load()
  --   vim.cmd.colorscheme("nordic")
  -- end,
  -- },
  -- {
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       style = 'vulgaris',
  --     }
  --     require('bamboo').load()
  --   end,
  -- },

  -- "folke/tokyonight.nvim",
  -- priority = 1000,
  -- config = function()
  --   vim.cmd.colorscheme = "tokyonight"
  -- end,
  --
  -- "rebelot/kanagawa.nvim",
  -- priority = 1000,
  -- config = function()
  --   require("kanagawa").setup({
  --     -- theme = 'dragon',
  --   })
  --   vim.cmd.colorscheme("kanagawa-dragon")
  -- end,
}
