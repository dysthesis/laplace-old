{
  my = {
    impermanence = {
      enable = true;
      user.enable = true;
    };
    fs.zfs = {
      enable = true;
      sanoid.enable = true;
    };
    hardware = {
      cpu = "amd";
      gpu = "amd";
    };
    users = {
      apollyon.enable = true;
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
      bluetooth.enable = false;
    };
    security = {
      privilege-elevation = "sudo";
      firewall.enable = true;
      secure-boot.enable = false; # enable this once the system is installed and the keys are generated
    };
    boot.systemd-boot.enable = true;
  };

  # For things without modules.
  config = {
    security.polkit.enable = true;
  };
}
