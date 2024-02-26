{pkgs, ...}: {
  home.packages = with pkgs; [
    libsixel # for displaying images
  ];
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        # window settings
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        pad = "16x16 center";
        shell = "fish";

        # notifications
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "clipboard";

        # font and font rendering
        dpi-aware = true; # this looks more readable on a laptop, but it's unreasonably large
        font = "JetBrainsMono Nerd Font:size=10";
        font-bold = "JetBrainsMono Nerd Font:size=10";
        vertical-letter-offset = "-0.90";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      tweak = {
        font-monospace-warn = "no"; # reduces startup time
        sixel = "yes";
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
      };

      mouse = {
        hide-when-typing = "yes";
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file";
        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };

      colors = {
        foreground = "#ffffff"; # Text
        background = "#000000"; # Base

        regular0 = "#45475A"; # Surface 1
        regular1 = "#F38BA8"; # red
        regular2 = "#A6E3A1"; # green
        regular3 = "#F9E2AF"; # yellow
        regular4 = "#89B4FA"; # blue
        regular5 = "#F5C2E7"; # pink
        regular6 = "#94E2D5"; # teal
        regular7 = "#c0c0c0"; # Subtext 0
        # Subtext 1 ???
        bright0 = "#585B70"; # Surface 2
        bright1 = "#F38BA8"; # red
        bright2 = "#A6E3A1"; # green
        bright3 = "#F9E2AF"; # yellow
        bright4 = "#89B4FA"; # blue
        bright5 = "#F5C2E7"; # pink
        bright6 = "#94E2D5"; # teal
        bright7 = "#d0d0d0"; # Subtext 0
      };
    };
  };
}
