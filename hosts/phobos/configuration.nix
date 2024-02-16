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
  };
}
