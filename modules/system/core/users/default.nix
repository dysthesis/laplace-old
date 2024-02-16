{config, ...}: {
  imports = [
    ./apollyon.nix
  ];

  # You can't make users mutable if impermanence is on.
  users.mutableUsers = !config.my.impermanence.enable;
}
