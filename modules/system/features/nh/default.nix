{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.features.nh.enable = mkEnableOption "Whether or not to use the nh Nix helper";
  config = mkIf config.my.features.nh.enable {
    environment.sessionVariables.FLAKE = "/home/apollyon/Documents/NixOS";
    environment.systemPackages = with pkgs; [
      nh
    ];
  };
}
