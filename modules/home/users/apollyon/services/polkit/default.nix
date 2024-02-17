{
  lib,
  pkgs,
  ...
}: let
  mkGraphicalService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  systemd.user.services.polkit-gnome-authentication-agent-1 = mkGraphicalService {
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
}
