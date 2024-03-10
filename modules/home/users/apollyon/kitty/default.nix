{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      italic_font = "JetBrainsMono Nerd Font Italic";
      bold_font = "JetBrainsMono Nerd Font";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
      font_size = 11;
      disable_ligatures = "never";
      confirm_os_window_close = 0;
      window_padding_width = 20;
      mouse_hide_wait = 0;
      focus_follows_mouse = "no";
      background_opacity = "0.85";

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
      modify_font cell_height 1.02
      click_interval 0.5
      cursor_blink_interval 0
      background #000000
      foreground #ffffff
      cursor     #ffffff
    '';
  };
}
