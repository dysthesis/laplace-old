{
  config,
  lib,
  pkgs,
  ...
}: let
  swww = lib.getExe pkgs.swww;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
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
