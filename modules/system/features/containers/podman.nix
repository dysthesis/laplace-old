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
    environment =
      {
        systemPackages = with pkgs; [podman-compose];
      }
      // mkIf config.my.impermanence.enable {
        # Please don't yeet out my root containers, impermanence.
        persistence."/nix/persist" = {
          directories = ["/var/lib/containers"];
        };
      };
    virtualisation.podman = {
      enable = cfg.enable;
      dockerCompat = true; # docker = podman (alias)
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
