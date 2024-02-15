{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix

    # We use disko to partition and manage our disks and filesystems
    inputs.disko.nixosModules.default
    (import ./disko.nix {device = "/dev/nvme0n1";})
  ];

  # Prioritise the /nix/persist filesystem for boot
  # to let impermanence do its thing.
  fileSystems."/nix/persist".neededForBoot = true;
}
