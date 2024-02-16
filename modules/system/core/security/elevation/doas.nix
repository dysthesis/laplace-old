{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my.security.privilege-elevation == "doas") {
    security.doas.enable = true;
    security.sudo.enable = false;
  };
}
