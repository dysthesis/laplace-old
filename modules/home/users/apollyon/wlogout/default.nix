{config, ...}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "gtklock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
    ];
    style = ''
      window {
          font-family: JetBrainsMono Nerd FOnt;
          font-size: 14pt;
          color: #cdd6f4; /* text */
          background-color: rgba(30, 30, 46, 0.8);
      }

      button {
          background-repeat: no-repeat;
          background-position: center;
          background-size: 50%;
          border: none;
          background-color: rgba(30, 30, 46, 0);
          margin: 5px;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:hover {
          background-color: rgba(49, 50, 68, 0.1);
      }

      button:focus {
          background-color: #b4befe;
          color: #1e1e2e;
      }

      #lock {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/lock.png"));
      }
      #lock:focus {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/lock-hover.png"));
      }

      #logout {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/logout.png"));
      }
      #logout:focus {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/logout-hover.png"));
      }

      #suspend {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/sleep.png"));
      }
      #suspend:focus {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/sleep-hover.png"));
      }

      #shutdown {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/power.png"));
      }
      #shutdown:focus {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/power-hover.png"));
      }

      #reboot {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/restart.png"));
      }
      #reboot:focus {
          background-image: image(url("${config.home.homeDirectory}/.config/wlogout/icons/restart-hover.png"));
      }
    '';
  };
  home.file = {
    ".config/wlogout/icons/lock.png".source = ./lock.png;
    ".config/wlogout/icons/lock-hover.png".source = ./lock-hover.png;
    ".config/wlogout/icons/logout.png".source = ./logout.png;
    ".config/wlogout/icons/logout-hover.png".source = ./logout-hover.png;
    ".config/wlogout/icons/sleep.png".source = ./sleep.png;
    ".config/wlogout/icons/sleep-hover.png".source = ./sleep-hover.png;
    ".config/wlogout/icons/power.png".source = ./power.png;
    ".config/wlogout/icons/power-hover.png".source = ./power-hover.png;
    ".config/wlogout/icons/restart.png".source = ./restart.png;
    ".config/wlogout/icons/restart-hover.png".source = ./restart-hover.png;
  };
}
