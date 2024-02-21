{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.hardening.malloc.enable = mkEnableOption "Whether or not to enable malloc hardening with scudo";
  config = mkIf config.my.hardening.malloc.enable {
    environment = {
      memoryAllocator.provider = "scudo";
      variables.SCUDO_OPTIONS = "ZeroContents=1";
    };
  };
}
