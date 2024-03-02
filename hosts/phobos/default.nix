{inputs, ...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    # We use disko to partition and manage our disks and filesystems
    inputs.disko.nixosModules.default

    # We want to use home-manager to manage our user configs
    inputs.home-manager.nixosModules.home-manager
    (import ./disko.nix {device = "/dev/nvme0n1";})
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
  };

  # Prioritise the /nix/persist and /nix/persist/home filesystem for boot
  # to let impermanence do its thing.
  fileSystems."/nix/persist".neededForBoot = true;
  #fileSystems."/nix/persist/home".neededForBoot = true;
}
