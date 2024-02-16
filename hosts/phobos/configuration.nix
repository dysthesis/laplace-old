{
  my = {
    impermanence = {
      enable = true;
      user.enable = true;
    };
    fs.zfs = {
      enable = true;
      sanoid.enable = true;
    };
    hardware = {
      cpu = "amd";
      gpu = "amd";
    };
    users = {
      apollyon.enable = true;
    };
    nix = {
      gc.enable = true;
      nvd.enable = true;
    };
    sound = {
      enable = true;
      server = "pipewire";
    };
    network = {
      wifi.enable = true;
      encrypted-dns.enable = true;
      bluetooth.enable = false;
    };
    security = {
      privilege-elevation = "sudo";
      firewall.enable = true;
      secure-boot.enable = false; # enable this once the system is installed and the keys are generated
    };
    boot.systemd-boot.enable = true;
  };

  # For things without modules.
  config = {
    security.polkit.enable = true;
    # Use the xanmod kernel
    boot = {
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
      tmp = {
        useTmpfs = lib.mkDefault true;
        cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
      };
    };
    time.timeZone = "Australia/Sydney";
    # this option defines the first version of nixos you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older nixos versions.
    #
    # most users should never change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new nixos release.
    #
    # this value does not affect the nixpkgs version your packages and os are pulled from,
    # so changing it will not upgrade your system.
    #
    # this value being lower than the current nixos release does not mean your system is
    # out of date, out of support, or vulnerable.
    #
    # do not change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # for more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateversion .
    system.stateversion = "23.11"; # did you read the comment?
  };
}
