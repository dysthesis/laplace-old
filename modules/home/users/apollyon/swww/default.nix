{
  config,
  lib,
  pkgs,
  ...
}: let
  swww = lib.getExe pkgs.swww;
in
  with lib; {
    systemd.user.services = {
      swww = mkService {
        Unit.Description = "Wallpaper chooser";
        Service = {
          ExecStart = "${swww} init && ${swww} img ${config.myHome.wallpaper}";
          Restart = "always";
        };
      };
    };
  }
