{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.virtualisation.enable = mkEnableOption "Whether or not to enable virtualisation via libvirtd";

  config = mkIf config.my.features.virtualisation.enable {
    virtualisation = {
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;

        # Maybe this is what was slowing down shutdowns
        parallelShutdown = 10;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true; # TODO figure out how to make it work when this is set to false.
          swtpm.enable = true;

          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };

        onBoot = "ignore";
        onShutdown = "shutdown";
      };
    };

    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu_kvm
      qemu
    ];

    # this allows libvirt to use pulseaudio socket
    # which is useful for virt-manager
    hardware.pulseaudio.extraConfig = ''
      load-module module-native-protocol-unix auth-group=qemu-libvirtd socket=/tmp/pulse-socket
    '';
  };
}
