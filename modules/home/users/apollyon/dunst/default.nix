{
  lib,
  pkgs,
  ...
}: let
  volume = let
    pamixer = lib.getExe pkgs.pamixer;
    notify-send = pkgs.libnotify + "/bin/notify-send";
  in
    pkgs.writeShellScriptBin "volume" ''
      #!/usr/bin/env sh
      ${pamixer} "$@"
      volume="$(${pamixer} --get-volume-human)"
      if [ "$volume" = "muted" ]; then
          ${notify-send} -r 69 \
              -a "󰝟 Volume" \
              "Muted" \
              -i ${./mute.svg} \
              -t 888 \
              -u low
      else
          ${notify-send} -r 69 \
              -a "󰕾 Volume" "Volume: $volume" \
              -h int:value:"$volume" \
              -i ${./volume.svg} \
              -t 888 \
              -u low
      fi
    '';
in {
  home.packages = [volume];
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = ["dracula"];
      };
      name = "Tela-dracula-dark";
    };
    settings = {
      global = {
        monitor = 1;
        frame_color = "#b4befe";
        separator_color = "#b4befe";
        width = 300;
        height = 380;
        offset = "0x15";
        font = "JetBrainsMono Nerd Font 12";
        corner_radius = 18;
        origin = "top-center";
        notification_limit = 3;
        idle_threshold = 120;
        ignore_newline = "no";
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        sticky_history = "yes";
        history_length = 20;
        show_age_threshold = 50;
        ellipsize = "middle";
        padding = 10;
        always_run_script = true;
        frame_width = 2;
        transparency = 60;
        progress_bar = true;
        progress_bar_frame_width = 0;
        highlight = "#b4befe";
        icon_position = "right";
      };
      fullscreen_delay_everything.fullscreen = "delay";
      urgency_low = {
        background = "#181825";
        foreground = "#c6d0f5";
        timeout = 5;
      };
      urgency_normal = {
        background = "#181825";
        foreground = "#c6d0f5";
        timeout = 6;
      };
      urgency_critical = {
        background = "#181825";
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
