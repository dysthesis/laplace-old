{
  imports = [./systemd-boot.nix];

  config.boot = {
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
  };
}
