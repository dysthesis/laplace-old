{
  config,
  lib,
  ...
}: {
  options.my.boot.systemd-boot.enable = lib.mkEnableOption "Whether or not to enable systemd-boot";
  config = lib.mkIf config.my.boot.systemd-boot.enable {
    boot.loader = {
      systemd-boot = {
        enable = lib.mkDefault true;
        editor = false;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 5;
    };
  };
}
