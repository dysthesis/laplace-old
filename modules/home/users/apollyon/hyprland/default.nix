{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    settings = {
      ## MONITORS ##
      monitor =
        map
        (
          m: let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in "${m.name},${
            if m.enabled
            then "${resolution},${position},1"
            else "disable"
          }"
        )
        config.myHome.monitors;

      ## KEYBINDINGS ##
      "$mod" = "SUPER";
      bind =
        [
          "$mod, Return, exec, wezterm"
          "$mod, R, ${lib.getExe pkgs.rofi-wayland} -show drun"
          ''$mod, P, exec, ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${lib.getExe pkgs.swappy} -f -''
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, focusworkspaceoncurrentmonitor, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        # keyboard layout
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          clickfinger_behavior = true;
          tap-to-click = false;
          scroll_factor = 0.5;
        };
      };

      general = {
        # gaps
        gaps_in = 6;
        gaps_out = 12;

        # border thiccness
        border_size = 2;

        # active border color
        "col.active_border" = "rgb(ffffff)";

        # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        apply_sens_to_raw = 0;
      };

      decoration = {
        # fancy corners
        rounding = 12;

        # blur
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
        };

        # shadow config
        drop_shadow = "yes";
        shadow_range = 20;
        shadow_render_power = 5;
        "col.shadow" = "rgba(292c3cee)";
      };

      misc = {
        # disable redundant renders
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;

        vfr = true;

        # window swallowing
        enable_swallow = true; # hide windows that spawn other windows
        swallow_regex = "^(wezterm)$";

        # dpms
        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action
        disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
      };

      dwindle = {
        pseudotile = false;
        preserve_split = "yes";
        no_gaps_when_only = false;
      };

      ## ANIMATIONS ##
      animations = {
        enabled = true;
        first_launch_animation = true;

        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 7, fluent_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      ## INITIALISATION ##
      exec-once = [
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
      ];
    };
  };
}