{pkgs, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 20;
          y = 20;
        };
      };

      scrolling.history = 10000;

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        bold.family = "JetBrainsMono Nerd Font";
        italic.family = "JetBrainsMono Nerd Font";
        size = 10;
      };

      window.opacity = 0.75;

      colors.primary = {
        background = "#000000";
        foreground = "#ffffff";
        dim_foreground = "#ffffff";
        bright_foreground = "#ffffff";
      };

      import = [
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/alacritty/071d73effddac392d5b9b8cd5b4b527a6cf289f9/catppuccin-mocha.toml";
          hash = "sha256-nmVaYJUavF0u3P0Qj9rL+pzcI9YQOTGPyTvi+zNVPhg=";
        })
      ];
    };
  };
}
