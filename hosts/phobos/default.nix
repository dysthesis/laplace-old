{inputs, ...}: {
  imports = [
		# This is our hardware-specific configurations
    ./hardware-configuration.nix

    # We use disko to partition and manage our disks and filesystems
    inputs.disko.nixosModules.default
    (import ./disko.nix {device = "/dev/nvme0n1";})
  ];
}
