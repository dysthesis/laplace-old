{
  config,
  lib,
  ...
}: {
  options.my.fs.zfs.enable = lib.mkEnableOption "Enable ZFS support";
  config = lib.mkIf config.my.fs.zfs.enable {
    boot.supportedFilesystems = ["zfs"];
    boot.initrd.supportedFilesystems = ["zfs"];

    /*
    This is needed for ZFS to check if a pool has been exported by the
    device it was last imported by before being imported to a different device.

    The value doesn't seem to matter, so this is simply the default ZFSBootMenu hostId.
    */
    networking.hostId = "00bab10c";
  };
}
