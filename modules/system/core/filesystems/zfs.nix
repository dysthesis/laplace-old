{
  config,
  lib,
  ...
}: {
  options.my.fs.zfs = {
    enable = lib.mkEnableOption "Enable ZFS support";
    sanoid.enable = lib.mkEnableOption "Enable sanoid";
  };
  config =
    lib.mkIf config.my.fs.zfs.enable {
      boot.supportedFilesystems = ["zfs"];
      boot.initrd.supportedFilesystems = ["zfs"];

      zfs = {
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
