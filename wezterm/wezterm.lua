local wezterm = require("wezterm")

local function font_with_fallback(name, params)
  local names = { name, "Noto Color Emoji", "FiraCode Nerd Font" }
  return wezterm.font_with_fallback(names, params)
end

-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local Grey = "#0f1419"
local LightGrey = "#191f26"

local TAB_BAR_BG = "Black"
local ACTIVE_TAB_BG = "Yellow"
local ACTIVE_TAB_FG = "Black"
local HOVER_TAB_BG = Grey
local HOVER_TAB_FG = "White"
local NORMAL_TAB_BG = LightGrey
local NORMAL_TAB_FG = "White"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  panes = panes
  config = config
  max_width = max_width

  local background = NORMAL_TAB_BG
  local foreground = NORMAL_TAB_FG

  local is_first = tab.tab_id == tabs[1].tab_id
  local is_last = tab.tab_id == tabs[#tabs].tab_id

  if tab.is_active then
    background = ACTIVE_TAB_BG
    foreground = ACTIVE_TAB_FG
  elseif hover then
    background = HOVER_TAB_BG
    foreground = HOVER_TAB_FG
  end

  local leading_fg = NORMAL_TAB_FG
  local leading_bg = background

  local trailing_fg = background
  local trailing_bg = NORMAL_TAB_BG

  if is_first then
    leading_fg = TAB_BAR_BG
  else
    leading_fg = NORMAL_TAB_BG
  end

  if is_last then
    trailing_bg = TAB_BAR_BG
  else
    trailing_bg = NORMAL_TAB_BG
  end

  local title = tab.active_pane.title
  -- broken?
  -- local title = " " .. wezterm.truncate_to_width(tab.active_pane.title, 30) .. " "

  return {
    { Attribute = { Italic = false } },
    { Attribute = { Intensity = hover and "Bold" or "Normal" } },
    { Background = { Color = leading_bg } },
    { Foreground = { Color = leading_fg } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. title .. " " },
    { Background = { Color = trailing_bg } },
    { Foreground = { Color = trailing_fg } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

return {
  check_for_updates = true,
  check_for_updates_interval_seconds = 86400,
  show_update_window = true,
  window_decorations = "RESIZE",
  window_padding = {
    --   left = 0,
    --   right = 0,
    --   top = 0,
    bottom = 0,
  },
  native_macos_fullscreen_mode = true,
  -- default_cursor_style = "BlinkingBlock",

  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  tab_max_width = 64,

  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },

  color_scheme = "Catppuccin Mocha",
  colors = {
    tab_bar = {
      background = TAB_BAR_BG,
    },
  },

  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.75,
  },

  font_size = 13,

  tab_bar_style = {
    new_tab = wezterm.format({
      { Background = { Color = HOVER_TAB_BG } },
      { Foreground = { Color = TAB_BAR_BG } },
      {
        Text = SOLID_RIGHT_ARROW,
      },
      { Background = { Color = HOVER_TAB_BG } },
      {
        Foreground = { Color = HOVER_TAB_FG },
      },
      { Text = " + " },
      { Background = { Color = TAB_BAR_BG } },
      { Foreground = { Color = HOVER_TAB_BG } },
      {
        Text = SOLID_RIGHT_ARROW,
      },
    }),
    new_tab_hover = wezterm.format({
      { Attribute = { Italic = false } },
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = NORMAL_TAB_BG } },
      { Foreground = { Color = TAB_BAR_BG } },
      {
        Text = SOLID_RIGHT_ARROW,
      },
      { Background = { Color = NORMAL_TAB_BG } },
      {
        Foreground = { Color = NORMAL_TAB_FG },
      },
      { Text = " + " },
      { Background = { Color = TAB_BAR_BG } },
      { Foreground = { Color = NORMAL_TAB_BG } },
      {
        Text = SOLID_RIGHT_ARROW,
      },
    }),
  },

  keys = {
    {
      key = "d",
      mods = "SUPER|SHIFT",
      action = wezterm.action({ SplitVertical = {
        domain = "CurrentPaneDomain",
      } }),
    },
    {
      key = "d",
      mods = "SUPER",
      action = wezterm.action({ SplitHorizontal = {
        domain = "CurrentPaneDomain",
      } }),
    },
    { key = "h", mods = "SUPER|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "l", mods = "SUPER|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "j", mods = "SUPER|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    { key = "k", mods = "SUPER|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "w", mods = "SUPER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    {
      key = "Enter",
      mods = "SUPER",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = "p",
      mods = "SUPER",
      action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
    },

    {
      key = ".",
      mods = "SUPER",
      action = wezterm.action.ActivateCommandPalette,
    },
    -- Go to beginning of line
    {
      key = "LeftArrow",
      mods = "CMD",
      action = wezterm.action.SendKey({
        key = "a",
        mods = "CTRL",
      }),
    },

    -- Go to end of line
    {
      key = "RightArrow",
      mods = "CMD",
      action = wezterm.action.SendKey({ key = "e", mods = "CTRL" }),
    },
    -- Jump word to the left
    {
      key = "LeftArrow",
      mods = "OPT",
      action = wezterm.action.SendKey({
        key = "b",
        mods = "ALT",
      }),
    },

    -- Jump word to the right
    {
      key = "RightArrow",
      mods = "OPT",
      action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
    },
  },

  -- font = font_with_fallback("FiraCode Nerd"),
  -- font = font_with_fallback("Monaspace Argon"),
  font = font_with_fallback("JetBrains Mono", { weight = "DemiBold" }),
  -- font = font_with_fallback("JetBrains Mono NL"),
}
