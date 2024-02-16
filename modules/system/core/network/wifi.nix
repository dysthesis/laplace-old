{
  config,
  lib,
  ...
}: {
  options.my.network.wifi.enable = lib.mkEnableOption "Whether or not to enable wifi support.";
  config = lib.mkIf config.my.network.wifi.enable {
    networking.networkmanager = {
      enable = true;

      # I don't see a downside to randomised MAC addresses, so I'm just going to put it here.
      wifi.macAddress = "random";
    };
    programs.nm-applet = {
      enable = true;
      indicator = true;
    };
  };
}
