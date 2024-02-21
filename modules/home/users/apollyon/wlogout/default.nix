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
          font-family: SF Pro DIsplay;
          font-size: 12pt;
          color: #ffffff; /* text */
          background-color: rgba(0, 0, 0, 0.8);
      }

      button {
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          border: none;
          background-color: rgba(255, 255, 255, 0);
          margin: 8px;
          transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:hover {
          background-color: rgba(49, 50, 68, 0.1);
      }

      button:focus {
          background-color: #ffffff;
          color: #000000;
      }

      #lock {
          background-image: image(url("${./lock.png}"));
      }
      #lock:focus {
          background-image: image(url("${./lock-hover.png}"));
      }

      #logout {
          background-image: image(url("${./logout.png}"));
      }
      #logout:focus {
          background-image: image(url("${./logout-hover.png}"));
      }

      #suspend {
          background-image: image(url("${./sleep.png}"));
      }
      #suspend:focus {
          background-image: image(url("${./sleep-hover.png}"));
      }

      #shutdown {
          background-image: image(url("${./power-hover.png}"));
      }
      #shutdown:focus {
          background-image: image(url("${./power-hover.png}"));
      }

      #reboot {
          background-image: image(url("${./restart.png}"));
      }
      #reboot:focus {
          background-image: image(url("${./restart-hover.png}"));
      }
    '';
  };
}
