{
  config,
  inputs,
  lib,
  ...
}: {
  options = {
    my.impermanence = {
      enable = lib.mkEnableOption "Enable system impermanence";
      user.enable = lib.mkEnableOption "Enable user impermanence";
    };
  };

  config =
    lib.mkIf config.my.impermanence.enable {
      imports = [inputs.impermanence.nixosModule];
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
    }
    // lib.mkIf config.my.impermanence.user.enable {
      home.persistence."/nix/persist/home" = {
        directories =
          [
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Org"
            ".gnupg"
            ".nixops"
            ".local/share/keyrings"
            ".local/share/direnv"
          ]
          ++ lib.mkIf config.my.editors.emacs.enable [
            ".config/emacs"
            ".config/doom"
          ];
      };
    };
}
