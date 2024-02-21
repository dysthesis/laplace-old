{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.security.apparmor.enable = lib.mkEnableOption "Whether or not to enable AppArmor.";

  config = lib.mkIf config.my.security.apparmor.enable {
    # stolen from https://github.com/NotAShelf/nyx/blob/319b1f6fe4d09ff84d83d1f8fa0d04e0220dfed7/modules/core/common/system/security/apparmor.nix#L7

    services.dbus.apparmor = "disabled";

    # apparmor configuration
    security.apparmor = {
      enable = true;

      # whether to enable the AppArmor cache
      # in /var/cache/apparmore
      enableCache = true;

      # whether to kill processes which have an AppArmor profile enabled
      # but are not confined
      killUnconfinedConfinables = true;

      # packages to be added to AppArmor’s include path
      packages = [pkgs.apparmor-profiles];

      # apparmor policies
      policies = {
        "default_deny" = {
          enforce = false;
          enable = false;
          profile = ''
            profile default_deny /** { }
          '';
        };

        "sudo" = {
          enforce = false;
          enable = false;
          profile = ''
            ${pkgs.sudo}/bin/sudo {
              file /** rwlkUx,
            }
          '';
        };

        "nix" = {
          enforce = false;
          enable = false;
          profile = ''
            ${config.nix.package}/bin/nix {
              unconfined,
            }
          '';
        };
      };
    };
  };
}
