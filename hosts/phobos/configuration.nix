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
      secure-boot.enable = true; # enable this once the system is installed and the keys are generated
      apparmor.enable = true;
      polkit.enable = true;
      clamav.enable = true;
    };

    hardening = {
      kernel.enable = true;
      malloc.enable = false; # this is too annoying for now
    };

    boot.systemd-boot.enable = false;

    display.wayland = {
      enable = true;
      environments = ["hyprland"];
    };

    services.zram.enable = true;

    features = {
      virtualisation.enable = true;
      containers.podman.enable = true;
      ollama.enable = true;
      gaming.steam.enable = true;
      rss.miniflux.enable = true;
    };
  };

  # For things without modules.
  config = {
    security.polkit.enable = true;
    services = {
      gnome.gnome-keyring.enable = true;
      udisks2.enable = true;
    };
    boot = {
      tmp = {
        useTmpfs = lib.mkDefault true;
        cleanOnBoot = lib.mkDefault (!config.boot.tmp.useTmpfs);
      };
    };

    time.timeZone = "Australia/Sydney";

    environment.systemPackages = with pkgs; [
      terminus_font
      alejandra
    ];

    # Select internationalisation properties.
    i18n.defaultLocale = "en_AU.UTF-8";

    console = {
      earlySetup = true;
      font = "${pkgs.terminus_font}/share/consolefonts/ter-122n.psf.gz";
      packages = [pkgs.terminus_font];
    };

    /*
    This is needed for ZFS to check if a pool has been exported by the
    device it was last imported by before being imported to a different device.

    The value doesn't seem to matter, so this is simply the default ZFSBootMenu hostId.
    */
    networking.hostId = "00bab10c";
    networking.hostName = "phobos";

    # disable coredump that could be exploited later
    # and also slow down the system when something crash
    systemd.coredump.enable = false;

    # required to run chromium
    security.chromiumSuidSandbox.enable = true;

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
