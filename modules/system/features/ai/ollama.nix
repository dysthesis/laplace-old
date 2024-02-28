{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.features.ollama.enable = mkEnableOption "Whether or not to enable OLLaMa";
  config = mkIf config.my.features.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration =
        if (config.my.hardware.gpu == "amd")
        then "rocm"
        else
          (
            if (config.my.hardware.gpu == "nvidia")
            then "cuda"
            else null
          );
    };
  };
}
