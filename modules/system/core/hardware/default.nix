{lib, ...}: {
  imports = [
    ./amd.nix
  ];

  # Note that I only have AMD hardware, so the Intel and NVIDIA
  # options aren't fleshed out yet.
  options.my.hardware = {
    cpu = lib.mkOption {
      type = lib.types.enum ["amd" "intel"];
      default = "amd";
      description = "The manufacturer of the CPU";
    };
    gpu = lib.mkOption {
      types = lib.types.enum ["amd" "intel" "nvidia"];
      default = "amd";
      description = "The manufacturer of the GPU";
    };
  };
}
