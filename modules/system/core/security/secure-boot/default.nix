{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.my.security.secure-boot.enable = lib.mkEnableOption "Whether or not to enable secure boot.";
  config = lib.mkIf config.my.security.secure-boot.enable {
    # Can't use systemd-boot with Lanzaboote
    imports = [inputs.lanzaboote.nixosModules.lanzaboote];
    my.boot.systemd-boot.enable = lib.mkForce false;
    environment.systemPackages = [
      pkgs.sbctl
    ];
    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot = {
      bootspec.enable = true;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
