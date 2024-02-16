{
  config,
  lib,
  inputs,
  ...
}:
with lib; {
  config = mkIf (config.my.display.wayland.enable && (builtins.elem "hyprland" config.my.display.wayland.environments)) {
    services.xserver.displayManager.sessionPackages = [
      inputs.hyprland.packages.x86_64-linux.default
    ];

    xdg.portal = {
      enable = true;
      wlr.enable = mkDefault false;
      extraPortals = [
        inputs.xdg-portal-hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;

      # deprecated
      # enableNvidiaPatches = config.my.hardware.gpu == "nvidia";
    };
  };
}
