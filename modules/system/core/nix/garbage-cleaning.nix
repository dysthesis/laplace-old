{
  config,
  lib,
  ...
}: {
  options.my.nix.gc = {
    enable = lib.mkEnableOption "Enable Nix garbage cleaning";
    duration = lib.mkOption {
      type = lib.types.int;
      default = 7;
      description = "The minimum age in days for an item to be deleted.";
    };
  };

  config = lib.mkIf config.my.nix.gc.enable {
    nix.gc = {
      automatic = config.my.nix.gc.enable;
      dates = "daily";
      options = "--delete-older-than ${config.my.nix.gc.duration}d";
    };
  };
}
