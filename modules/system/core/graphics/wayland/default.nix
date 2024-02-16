{lib, ...}: {
  imports = [
    ./hyprland.nix
  ];
  options.my = with lib; {
    display.wayland.enable = mkEnableOption "Whether or not to enable Wayland.";
    display.wayland.environments = mkOption {
      type = types.listOf types.enum [
        "hyprland"
      ];
      example = ["hyprland"];
      default = [];
      description = "The list of environments to enable.";
    };
  };
}
