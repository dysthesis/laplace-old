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

      # Impermanence means that sudo will forget that it already displayed the lecture
      # so disable it outright for convenience's sake.
      extraConfig = ''
        Defaults lecture = never
      '';
    };
    security.doas.enable = false;
  };
}
