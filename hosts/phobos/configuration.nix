{
  config,
  pkgs,
  lib,
  ...
}: {
  config.my = {
    impermanence = {
      enable = true;
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
    display.wayland = {
      enable = true;
      environments = ["hyprland"];
    };
  };

  config.myHome = {
    monitors = [
      {
        name = "DP-0";
        width = 1920;
        height = 1080;
        refreshRate = 60.0;
        x = 0;
        y = 0;
      }
      {
        name = "DP-1";
        width = 1920;
        height = 1080;
        refreshRate = 165.0;
        x = 1920;
        y = 0;
      }
    ];
    wallpaper = ../../modules/home/shared/wallpapers/wallhaven-6dwmmw.png;
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

    # Select internationalisation properties.
    i18n.defaultLocale = "en_AU.UTF-8";
    console = {
      font = "${pkgs.terminus_font}/share/consolefonts/ter-118n.psf.gz";
      # useXkbConfig = true; # use xkbOptions in tty.
    };
    /*
    This is needed for ZFS to check if a pool has been exported by the
    device it was last imported by before being imported to a different device.

    The value doesn't seem to matter, so this is simply the default ZFSBootMenu hostId.
    */
    networking.hostId = "00bab10c";
    networking.hostName = "phobos";
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
    system.stateVersion = "23.11"; # did you read the comment?
  };
}
