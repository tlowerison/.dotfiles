local catppuccin_config = require("catppuccin_config")
local catppuccin_theme = "mocha"
local catppuccin_colors = catppuccin_config.color_overrides[catppuccin_theme]

local wezterm = require("wezterm")
local action = wezterm.action

local config = {}

config.default_cursor_style = "SteadyBar"
config.enable_scroll_bar = true
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
config.native_macos_fullscreen_mode = true
config.scrollback_lines = 3500

config.colors = {
   foreground = catppuccin_colors.text, 
   background = catppuccin_colors.base, 
}

config.keys = {
  -- TODO: expand pane size, shrink pane size
  -- clear consle with CMD+K
  {
    key = "k",
    mods = "CMD",
    action = action.Multiple({
      action.ClearScrollback("ScrollbackAndViewport"),
      action.SendKey({ key = "L", mods = "CTRL" }),
    }),
  },
  -- close current pane
  {
    key = "w",
    mods = "CMD",
    action = action.CloseCurrentPane{confirm=false},
  },
  -- split pane vertically
  {
    key = "d",
    mods = "CMD",
    action = action.SplitHorizontal({domain="CurrentPaneDomain"}),
  },
  -- split pane horizontally
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = action.SplitVertical({domain="CurrentPaneDomain"}),
  },
  -- rotate to next pane
  {
    key = "n",
    mods = "CMD|SHIFT",
    action = action.ActivatePaneDirection("Next"),
  },
  -- rotate to previous pane
  {
    key = "p",
    mods = "CMD|SHIFT",
    action = action.ActivatePaneDirection("Prev"),
  },
  -- backspace one word
  {
    key = "Backspace",
    mods = "OPT",
    action = action.SendString("\x17"),
  },
  -- delete all characters left of cursor
  -- NOTE: Requires configuration in .zshrc `bindkey "\\x15" backward-kill-line`
  {
    key = "Backspace",
    mods = "CMD",
    action = action.SendString("\x15"),
  },
  -- delete all characters left of cursor (NOTE: Requires special configuration in .zshrc)
  {
    key = "Backspace",
    mods = "CMD",
    action = action.SendString("\x15"),
  },
  -- move backward one word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = action.SendString("\x1bb"),
  },
  -- move forward one word
  {
    key = "RightArrow",
    mods = "OPT",
    action = action.SendString("\x1bf"),
  },
  -- move to top
  {
    key = "UpArrow",
    mods = "CMD",
    action = action.ScrollToTop,
  },
  -- move to bottom
  {
    key = "DownArrow",
    mods = "CMD",
    action = action.ScrollToBottom,
  },
  -- move cursor to start of line
  {
    key = "LeftArrow",
    mods = "CMD",
    action = action.SendString("\x01"),
  },
  -- move cursor to end of line
  {
    key = "RightArrow",
    mods = "CMD",
    action = action.SendString("\x05"),
  },
  {
    key = "i",
    mods = "CMD",
    action = action.ActivateCopyMode,
  },
}

return config
