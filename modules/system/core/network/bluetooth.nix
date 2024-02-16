{
  config,
  lib,
  ...
}: {
  options.my.network.bluetooth.enable = lib.mkEnableOption "Whether or not to enable Bluetooth support.";
  config = lib.mkIf config.my.network.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
