{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkForce;
in {
  options.my.fs.zfs = {
    enable = mkEnableOption "Enable ZFS support";
    sanoid.enable = mkEnableOption "Enable sanoid";
  };
  config =
    mkIf config.my.fs.zfs.enable {
      boot = {
        enabled = true;
        enableUnstable = true; # so I don't get stuck on an old kernel
        kernelPackages = mkForce config.boot.zfs.package.latestCompatibleLinuxPackges;
        supportedFilesystems = ["zfs"];
        initrd.supportedFilesystems = ["zfs"];
      };
      services.zfs = {
        autoScrub.enable = true;
        trim.enable = true;
      };
    }
    // lib.mkIf config.my.fs.zfs.sanoid.enable {
      services.sanoid = {
        enable = true;
        templates.default = {
          hourly = 24;
          daily = 7;
          monthly = 3;
          yearly = 3;
          autosnap = true;
          autoprune = true;
        };
        datasets."styx" = {
          useTemplate = ["default"];
          recursive = true;
        };
      };
    };
}
