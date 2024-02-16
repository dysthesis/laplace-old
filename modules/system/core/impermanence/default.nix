{
  config,
  inputs,
  lib,
  ...
}: {
  options.my.impermanence.enable = lib.mkEnableOption "Enable system impermanence";

  config = lib.mkIf config.my.impermanence.enable {
    imports = [inputs.impermanence.nixosModule];
    programs.fuse.userAllowOther = true;
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager"
        "/etc/ssh"
        "/etc/NetworkManager/system-connections"
        "/var/lib/flatpak"
        "/var/lib/libvirt"
        "/var/lib/bluetooth"
        "/etc/secureboot"
      ];
      files = ["/etc/machine-id"];
    };
  };
}
