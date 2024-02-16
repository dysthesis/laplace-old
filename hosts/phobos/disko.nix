{device ? throw "Set this to your disk device, e.g. /dev/nvme0n1", ...}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";

              /*
              This part is rather opinionated, and will require
              boot.efi.efiSysMountPoint to be set to the same directory.
              */
              mountpoint = "/boot/efi";
            };
          };

          swap = {
            size = "4G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };

          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";

              /*
              Disko should ask for an encryption password interactively.
              To use a password file instead for a fully unattended installation,
              uncomment the following and adjust it to point to your password file.
              */

              # passwordFile = "/tmp/secret.key"
              settings = {
                allowDiscards = true;

                /*
                For an unattended boot, uncomment the following and point it
                to your keyfile
                */
                # keyFile = "/tmp/secret.key";
              };

              content = {
                type = "zfs";
                pool = "styx";
              };
            };
          };
        };
      };
    };

    zpool.styx = {
      type = "zpool";
      rootFsOptions = {
        acltype = "posixacl";
        compression = "zstd";
        dnodesize = "auto";
        normalization = "formD";
        relatime = "on";
        xattr = "sa";

        # Use sanoid instead.
        "com.sun:auto-snapshot" = "false";
      };

      mountpoint = "/";
      postCreateHook = "zfs snapshot styx@blank";

      datasets = {
        # This will be the parent dataset that contains system-related files.
        "nixos" = {
          type = "zfs_fs";
          options.mountpoint = "none";
        };

        "nixos/nix" = {
          type = "zfs_fs";

          /*
          If I understand this correctly, 'mountpoint' is used by NixOS internally
               whereas 'options.mountpoint' is what's stored by ZFS itself.

          Since NixOS manages ZFS mountpoints by itself, the mountpoint stored on ZFS
          itself must be set to 'legacy', else they will clash.
          */

          mountpoint = "/nix";
          options.mountpoint = "legacy";
        };

        "nixos/persist" = {
          type = "zfs_fs";
          mountpoint = "/nix/persist";
          options.mountpoint = "legacy";
        };

        "nixos/persist/home" = {
          type = "zfs_fs";
          mountpoint = "/nix/persist/home";
          options.mountpoint = "legacy";
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
