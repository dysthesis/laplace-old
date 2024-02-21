{
  pkgs,
  lib,
  ...
}: let
  bgImageSection = name: ''
     #${name} {
       background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    margin: 8px;
     }
  '';
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Log out";
        keybind = "e";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }
    ];
    style = ''
      		window {
          background-color: #000000;
      }

      button {
          color: #ffffff;
          background-color: #0f0f0f;
          outline-style: none;
          border: none;
          border-width: 0px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 20%;
          border-radius: 0px;
          box-shadow: none;
          text-shadow: none;
          animation: gradient_f 20s ease-in infinite;
      }

      button:focus {
          background-color: #1f1f1f;
          background-size: 30%;
      }

      button:hover {
          background-color: #0f0f0f;
          background-size: 40%;
          border-radius: 12px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:hover#lock {
          border-radius: 12px;
          margin : 8px 0px 8px 8px;
      }

      button:hover#logout {
          border-radius: 12px;
          margin : 8px 0px 8px 0px;
      }

      button:hover#shutdown {
          border-radius: 12px;
          margin : 8px 0px 8px 0px;
      }

      button:hover#reboot {
          border-radius: 12px;
          margin : 8px 8px 8px 0px;
      }

            ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}
