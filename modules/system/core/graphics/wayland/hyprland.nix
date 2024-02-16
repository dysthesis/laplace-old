{
  config,
  lib,
  inputs,
  ...
}:
with lib; {
  config = mkIf (config.my.display.wayland.enable && (builtins.elem "hyprland" config.my.display.wayland.environments)) {
    services.xserver.displayManager.sessionPackages = [
      inputs.hyprland.packages.default
    ];

    xdg.portal = {
      enable = true;
      wlr.enable = mkDefault false;
      extraPortals = [
        inputs.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = config.my.hardware.gpu == "nvidia";
      portalPackage = [
        inputs.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland
      ];
    };
  };
}
