{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my.security.privilege-elevation == "sudo") {
    security.sudo = {
      wheelNeedsPassword = true;
      execWheelOnly = true;
      enable = true;
    };
    security.doas.enable = false;
  };
}
