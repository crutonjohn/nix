local wezterm = require("wezterm")

return {
  -- Font
  font = wezterm.font("CaskaydiaCove Nerd Font"),
  -- Font size
  font_size = 13.0,
  -- Colorscheme
  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 0.9,
  -- Tab Bar
  hide_tab_bar_if_only_one_tab = true,

  -- Padding
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },

}
