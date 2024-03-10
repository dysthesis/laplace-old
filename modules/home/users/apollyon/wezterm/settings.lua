      local wezterm = require ("wezterm")

      local function font_with_fallback(name, params)
        local names = { name, "Material Symbols Outlined"}
        return wezterm.font_with_fallback(names, params)
      end

      local font_name = "JetBrainsMono Nerd Font"

      return {

        colors = {
          background = "#000000",
      		foreground = "#ffffff",
        },

      font_size = 12,
      line_height = 1.1,

      front_end = "WebGpu",
      webgpu_power_preference = "HighPerformance",

        color_scheme = "Catppuccin Mocha",
        window_background_opacity = 0.85,
        warn_about_missing_glyphs = false,
        enable_scroll_bar = false,
        enable_tab_bar = false,
        scrollback_lines = 10000,
        window_padding = {
          left = 25,
          right = 25,
          top = 25,
          bottom = 25,
        },
        enable_wayland = true,
        check_for_updates = false,
        default_cursor_style = "SteadyBar",
        automatically_reload_config = true,

        disable_default_key_bindings = true,
        keys = {
          {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
          },
          {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
          },
          },
            window_close_confirmation = "NeverPrompt",
          }

