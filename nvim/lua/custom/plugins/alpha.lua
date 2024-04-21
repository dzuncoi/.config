-- local M = {
--   'goolord/alpha-nvim',
-- }
--
-- function M.config()
--   local alpha = require 'alpha'
--   local dashboard = require 'alpha.themes.dashboard'
--
--   math.randomseed(os.time())
--
--   local function pick_color()
--     local colors = { 'String', 'Identifier', 'Keyword', 'Number' }
--     return colors[math.random(#colors)]
--   end
--
--   local function footer()
--     local datetime = os.date ' %d-%m-%Y   %H:%M:%S'
--     local version = vim.version()
--     local nvim_version_info = '   v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
--
--     return datetime .. ' ' .. nvim_version_info
--   end
--
--   -- Set header
--   dashboard.section.header.val = {
--     '▓█████▄ ▒███████▒ █    ██  ███▄    █  ▄████▄   ▒█████   ██▓',
--     '▒██▀ ██▌▒ ▒ ▒ ▄▀░ ██  ▓██▒ ██ ▀█   █ ▒██▀ ▀█  ▒██▒  ██▒▓██▒',
--     '░██   █▌░ ▒ ▄▀▒░ ▓██  ▒██░▓██  ▀█ ██▒▒▓█    ▄ ▒██░  ██▒▒██▒',
--     '░▓█▄   ▌  ▄▀▒   ░▓▓█  ░██░▓██▒  ▐▌██▒▒▓▓▄ ▄██▒▒██   ██░░██░',
--     '░▒████▓ ▒███████▒▒▒█████▓ ▒██░   ▓██░▒ ▓███▀ ░░ ████▓▒░░██░',
--     '▒▒▓  ▒ ░▒▒ ▓░▒░▒░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒ ░ ░▒ ▒  ░░ ▒░▒░▒░ ░▓',
--     '░ ▒  ▒ ░░▒ ▒ ░ ▒░░▒░ ░ ░ ░ ░░   ░ ▒░  ░  ▒     ░ ▒ ▒░  ▒ ░',
--     '░ ░  ░ ░ ░ ░ ░ ░ ░░░ ░ ░    ░   ░ ░ ░        ░ ░ ░ ▒   ▒ ░',
--     '░      ░ ░       ░              ░ ░ ░          ░ ░   ░',
--     '░      ░                            ░',
--   }
--
--   dashboard.section.header.opts.hl = pick_color()
--
--   -- Set menu
--   dashboard.section.buttons.val = {
--     -- dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
--     dashboard.button('<leader>sf', '  > Find file', ':Telescope find_files<CR>'),
--     dashboard.button('<leader>?', '  > Recent', ':Telescope oldfiles<CR>'),
--     dashboard.button('s', '  > Settings', ':e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>'),
--     dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
--   }
--
--   dashboard.section.footer.val = footer()
--   dashboard.section.footer.opts.hl = 'Constant'
--
--   alpha.setup(dashboard.opts)
--
--   vim.cmd [[
--     autocmd FileType alpha setlocal nofoldenable
--   ]]
-- end
--
-- return M

---------------------
local ownLines = {
  '▓█████▄ ▒███████▒ █    ██  ███▄    █  ▄████▄   ▒█████   ██▓',
  '▒██▀ ██▌▒ ▒ ▒ ▄▀░ ██  ▓██▒ ██ ▀█   █ ▒██▀ ▀█  ▒██▒  ██▒▓██▒',
  '░██   █▌░ ▒ ▄▀▒░ ▓██  ▒██░▓██  ▀█ ██▒▒▓█    ▄ ▒██░  ██▒▒██▒',
  '░▓█▄   ▌  ▄▀▒   ░▓▓█  ░██░▓██▒  ▐▌██▒▒▓▓▄ ▄██▒▒██   ██░░██░',
  '░▒████▓ ▒███████▒▒▒█████▓ ▒██░   ▓██░▒ ▓███▀ ░░ ████▓▒░░██░',
  '▒▒▓  ▒ ░▒▒ ▓░▒░▒░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒ ░ ░▒ ▒  ░░ ▒░▒░▒░ ░▓',
  '░ ▒  ▒ ░░▒ ▒ ░ ▒░░▒░ ░ ░ ░ ░░   ░ ▒░  ░  ▒     ░ ▒ ▒░  ▒ ░',
  '░ ░  ░ ░ ░ ░ ░ ░ ░░░ ░ ░    ░   ░ ░ ░        ░ ░ ░ ▒   ▒ ░',
  '░      ░ ░       ░              ░ ░ ░          ░ ░   ░',
  '░      ░                            ░',
}

local coolLines = {
  [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
  [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
  [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
  [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
  [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
  [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
  [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
  [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
  [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
  [[███████╗████████╗██╗   ██╗███████╗███████╗]],
  [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
  [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
  [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
  [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
  [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
}

local robustLines = {
  [[        ██████╗ ██╗   ██╗██╗██╗     ██████╗         ]],
  [[        ██╔══██╗██║   ██║██║██║     ██╔══██╗        ]],
  [[        ██████╔╝██║   ██║██║██║     ██║  ██║        ]],
  [[        ██╔══██╗██║   ██║██║██║     ██║  ██║        ]],
  [[        ██████╔╝╚██████╔╝██║███████╗██████╔╝        ]],
  [[        ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝         ]],
  [[ ██████╗  ██████╗ ██████╗ ██╗   ██╗███████╗████████╗]],
  [[ ██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝]],
  [[ ██████╔╝██║   ██║██████╔╝██║   ██║███████╗   ██║   ]],
  [[ ██╔══██╗██║   ██║██╔══██╗██║   ██║╚════██║   ██║   ]],
  [[ ██║  ██║╚██████╔╝██████╔╝╚██████╔╝███████║   ██║   ]],
  [[ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ]],
  [[     ███████╗████████╗██╗   ██╗███████╗███████╗     ]],
  [[     ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝     ]],
  [[     ███████╗   ██║   ██║   ██║█████╗  █████╗       ]],
  [[     ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝       ]],
  [[     ███████║   ██║   ╚██████╔╝██║     ██║          ]],
  [[     ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝          ]],
}

local efficientLines = {
  [[             ██████╗██████╗  █████╗ ███████╗████████╗            ]],
  [[            ██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝            ]],
  [[            ██║     ██████╔╝███████║█████╗     ██║               ]],
  [[            ██║     ██╔══██╗██╔══██║██╔══╝     ██║               ]],
  [[            ╚██████╗██║  ██║██║  ██║██║        ██║               ]],
  [[             ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝               ]],
  [[███████╗███████╗███████╗██╗ ██████╗██╗███████╗███╗   ██╗████████╗]],
  [[██╔════╝██╔════╝██╔════╝██║██╔════╝██║██╔════╝████╗  ██║╚══██╔══╝]],
  [[█████╗  █████╗  █████╗  ██║██║     ██║█████╗  ██╔██╗ ██║   ██║   ]],
  [[██╔══╝  ██╔══╝  ██╔══╝  ██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ]],
  [[███████╗██║     ██║     ██║╚██████╗██║███████╗██║ ╚████║   ██║   ]],
  [[╚══════╝╚═╝     ╚═╝     ╚═╝ ╚═════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ]],
  [[  ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗███████╗  ]],
  [[  ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║██╔════╝  ]],
  [[  ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║███████╗  ]],
  [[  ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║  ]],
  [[  ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║███████║  ]],
  [[  ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝  ]],
}

local function lineToStartGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    table.insert(out, { hi = 'StartLogo' .. i, line = line })
  end
  return out
end

local function lineToStartPopGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local hi = 'StartLogo' .. i
    if i <= 6 then
      hi = 'StartLogo' .. i + 6
    elseif i > 6 and i <= 12 then
      hi = 'StartLogoPop' .. i - 6
    end
    table.insert(out, { hi = hi, line = line })
  end
  return out
end

local function lineToStartShiftGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local n = i
    if i > 6 and i <= 12 then
      n = i + 6
    elseif i > 12 then
      n = i - 6
    end
    table.insert(out, { hi = 'StartLogo' .. n, line = line })
  end
  return out
end

local own = lineToStartGradient(ownLines)
local cool = lineToStartPopGradient(coolLines)
local robust = lineToStartShiftGradient(robustLines)
local efficient = lineToStartGradient(efficientLines)

local headers = { own, cool, robust, efficient }

local function header_chars()
  math.randomseed(os.time())
  return headers[1]
  -- return headers[math.random(#headers)]
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
  local lines = {}
  table.insert(lines, 0, { type = 'padding', val = 2 })
  for _, lineConfig in pairs(header_chars()) do
    local hi = lineConfig.hi
    local line_chars = lineConfig.line
    local line = {
      type = 'text',
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = 'center',
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = 'group',
    val = lines,
    opts = { position = 'center' },
  }

  return output
end

local function footer()
  local datetime = os.date ' %d-%m-%Y   %H:%M:%S'
  local version = vim.version()
  local nvim_version_info = '   v' .. version.major .. '.' .. version.minor .. '.' .. version.patch

  return datetime .. ' ' .. nvim_version_info
end

local function configure()
  local theme = require 'alpha.themes.theta'
  local themeconfig = theme.config
  local dashboard = require 'alpha.themes.dashboard'

  local buttons = {
    type = 'group',
    val = {
      { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
      { type = 'padding', val = 1 },
      -- dashboard.button('e', '  New file', '<cmd>ene<CR>'),
      -- dashboard.button('SPC f', '󰍉  Find file'),
      -- dashboard.button('SPC F', '󰈞  Find text'),
      -- dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
      dashboard.button('<leader>sf', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('<leader>?', '  Recent', ':Telescope oldfiles<CR>'),
      dashboard.button('q', '󰩈  Quit', '<cmd>qa<CR>'),
      { type = 'padding', val = 1 },
      { type = 'text', val = footer(), opts = { hl = 'Number', position = 'center' } },
    },
    position = 'center',
  }

  themeconfig.layout[2] = header_color()
  themeconfig.layout[6] = buttons

  return themeconfig
end

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('alpha').setup(configure())
  end,
}
