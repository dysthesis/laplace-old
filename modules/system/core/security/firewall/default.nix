{
  config,
  lib,
  ...
}: {
  options.my.security.firewall.enable = lib.mkEnableOption "Whether or not to enable firewall";
  config = lib.mkIf config.my.security.firewall.enable {
    # enable opensnitch firewall
    # inactive until opensnitch UI is opened
    services.opensnitch.enable = true;

    networking.firewall = {
      enable = true;

      allowedTCPPorts = [443 8080];
      allowedUDPPorts = [];
      allowPing = false;
      logReversePathDrops = true;
      logRefusedConnections = false; # avoid log spam
      # Leaks IPv6 route table entries due to kernel bug. This leads to degraded
      # IPv6 performance in some situations.
      # checkReversePath = config.boot.kernelPackages.kernelAtLeast "5.16";
      checkReversePath = lib.mkForce false; # Don't filter DHCP packets, according to nixops-libvirtd
    };
  };
}
