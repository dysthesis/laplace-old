{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.features.containers.podman;
in {
  options.my.features.containers.podman.enable = mkEnableOption "Whether or not to enable Podman.";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [podman-compose];
    virtualisation.podman = {
      enable = true;
      dockerCompat = true; # docker = podman (alias)
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
      # For Nixos version > 22.11
      defaultNetwork.settings = {dns_enabled = true;};
    };
  };
}
