{pkgs, ...}: let
  weather = pkgs.stdenv.mkDerivation {
    name = "weather";
    buildInputs = [
      (pkgs.python311.withPackages
        (pythonPackages: with pythonPackages; [ftputil]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./scripts/weather.py} $out/bin/weather
      chmod +x $out/bin/weather
    '';
  };
  khal = pkgs.stdenv.mkDerivation {
    name = "khal";
    buildInputs = [
      (pkgs.python311.withPackages
        (pythonPackages: with pythonPackages; [sh]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./scripts/khal.py} $out/bin/khal
      chmod +x $out/bin/khal
    '';
  };
in {
  xdg.configFile."waybar/style.css".text = import ./style.nix;
  xdg.configFile."waybar/themes" = {
    source = ./themes;
    recursive = true;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {experimentalPatches = true;};

    # systemd.enable = true; # this breaks the khal module for some reason.

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        mod = "dock";
        height = 36;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        modules-left = [
          "custom/padd"
          "custom/l_end"
          "cpu"
          "memory"
          "disk"
          "custom/r_end"
          "custom/l_end"
          "hyprland/workspaces"
          "hyprland/window"
          "custom/r_end"
          ""
          "custom/padd"
        ];
        modules-center = [
          "custom/padd"
          "custom/l_end"
          "custom/weather"
          "custom/events"
          "clock"
          "custom/r_end"
          "custom/padd"
        ];
        modules-right = [
          "custom/padd"
          "custom/l_end"
          "tray"
          "custom/r_end"
          "custom/l_end"
          "network"
          "wireplumber"
          "custom/r_end"
          "custom/padd"
        ];
        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) - Mozilla Thunderbird" = " $1";
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) — Tor Browser" = " $1";
            "Tor Browser" = " Tor Browser";
            "(.*) - FreeTube" = "󰗃 $1";
            "(.*) – Doom Emacs" = " $1";
          };
        };
        memory = {
          format = "󰍛 {}% ";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };
        cpu = {
          format = "󰻠 {usage}% ";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };
        disk = {
          format = "󰋊 {}%";
          format-alt = "󰋊 {used}/{total} GiB";
          interval = 5;
          path = "/";
        };
        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "";
          on-click = "helvum";
          format-icons = ["" "" ""];
        };

        "custom/events" = {
          "format" = "{}";
          "tooltip" = true;
          "interval" = 300;
          "format-icons" = {
            "default" = "";
          };
          "exec" = "${khal}/bin/khal";
          "return-type" = "json";
        };
        clock = {
          rotate = 0;
          format = " {:%H:%M}";
          # format-alt = "{:%R 󰃭 %d·%m·%y}";
          tooltip-format = "<tt><big>{calendar}</big></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
        };
        tray = {
          icon-size = 18;
          spacing = 5;
        };
        network = {
          format-wifi = "󰤨 {essid}  {bandwidthUpBytes}  {bandwidthDownBytes} ";
          format-ethernet = "󱘖 Wired";
          tooltip-format = "󱘖 {ipaddr} ({signalStrength}%)";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = " Disconnected";
          format-alt = "󰤨 {signalStrength}%";
          interval = 5;
        };
        bluetooth = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
        };

        "custom/weather" = {
          tooltip = true;
          format = "{} ";
          interval = 30;
          exec = "${weather}/bin/weather waybar IDN10064";
          return-type = "json";
        };
        "custom/l_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/r_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/sl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/sr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/rl_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/rr_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/padd" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };
      };
    };
  };
}
