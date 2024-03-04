{
  pkgs,
  colors,
  ...
}:
with colors; {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      font_size = 10;
      disable_ligatures = "never";
      confirm_os_window_close = 0;
      window_padding_width = 20;
      adjust_line_height = 0;
      adjust_column_width = 0;
      box_drawing_scale = "0.01, 0.8, 1.5, 2";
      mouse_hide_wait = 0;
      focus_follows_mouse = "no";
      background_opacity = "0.65";

      # Performance
      repaint_delay = 15;
      input_delay = 2;
      sync_to_monitor = "no";

      # Bell
      visual_bell_duration = 0;
      enable_audio_bell = "no";
      bell_on_tab = "yes";
    };
    extraConfig = ''
      modify_font cell_height 0.93
      click_interval 0.5
      cursor_blink_interval 0
      background #000000
      foreground #ffffff
      cursor     #ffffff
    '';
  };
}
