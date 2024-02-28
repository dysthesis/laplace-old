{
  config,
  inputs,
  lib,
  ...
}: {
  options.my.impermanence.enable = lib.mkEnableOption "Enable system impermanence";
  imports = [inputs.impermanence.nixosModule];
  config = lib.mkIf config.my.impermanence.enable {
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
        "/var/lib/ollama"
        "/etc/secureboot"
      ];
      files = ["/etc/machine-id"];
    };
  };
}
