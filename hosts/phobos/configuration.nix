{
  my = {
    impermanence = {
      enable = true;
      user.enable = true;
    };
    fs.zfs.enable = true;
    hardware = {
      cpu = "amd";
      gpu = "amd";
    };
    nix = {
      gc.enable = true;
      nvd.enable = true;
    };
    sound = {
      enable = true;
      server = "pipewire";
    };
    network = {
      wifi.enable = true;
      encrypted-dns.enable = true;
    };
  };
}
