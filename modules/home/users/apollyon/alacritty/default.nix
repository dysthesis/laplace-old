{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 12;
          y = 12;
        };
      };

      scrolling.history = 10000;

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        bold.family = "JetBrainsMono Nerd Font";
        italic.family = "JetBrainsMono Nerd Font";
        size = 10;
      };

      draw_bold_text_with_bright_colors = true;
      window.opacity = 0.75;

      imports = [
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/alacritty/071d73effddac392d5b9b8cd5b4b527a6cf289f9/catppuccin-mocha.toml";
          hash = "sha256-28Tvtf8A/rx40J9PKXH6NL3h/OKfn3TQT1K9G8iWCkM=";
        })
      ];
    };
  };
}
