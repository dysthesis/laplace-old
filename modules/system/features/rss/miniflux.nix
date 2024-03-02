{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.features.rss.miniflux.enable = mkEnableOption "Whether or not to enable the Miniflux RSS feed reader";
  config = mkIf config.my.features.rss.miniflux.enable {
    services.miniflux = {
      enable = true;
      config = {
        LISTEN_ADDR = "localhost:80";
      };
      adminCredentialsFile = config.sops.secrets.miniflux_adminCredentials.path;
    };

    users.users.miniflux = {
      isSystemUser = true;
      group = "miniflux";
    };

    users.groups.miniflux = {};

    environment.persistence."/nix/persist" = mkIf config.my.impermanence.enable {
      directories = [
        {
          directory = "/var/lib/private/miniflux";
          mode = "0750";
          user = "miniflux";
          group = "miniflux";
        }
      ];
    };
  };
}
