-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night Storm"

-- Set Github Monospace font, patched with Nerd Fonts
-- https://monaspace.githubnext.com
-- config.font = wezterm.font("MonaspiceNe Nerd Font Mono") -- Neon: Neo-grotesque sans
config.font = wezterm.font("MonaspiceAr Nerd Font Mono", { weight = "Thin" }) -- Argon: Humanist sans
-- config.font = wezterm.font("MonaspiceXe Nerd Font Mono") -- Xenon: Slav serif
-- config.font = wezterm.font("MonaspiceKr Nerd Font Mono") -- Krypton: Mechanical sans
config.font_rules = {
  {
    italic = true,
    font = wezterm.font('MonaspiceRn Nerd Font Mono'), -- Radon: Handwriting
  },
}
config.font_size = 15
config.line_height = 1.1

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = "0cell",
  right = "0cell",
  top = "0cell",
  bottom = "0cell",
}
-- and finally, return the configuration to wezterm
return config
