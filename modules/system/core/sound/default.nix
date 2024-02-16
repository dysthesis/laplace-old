{lib, ...}: {
  imports = [
    ./pipewire.nix
  ];
  options.my.sound = {
    enable = lib.mkEnableOption "Enable sound server.";
    server = lib.mkOption {
      type = lib.types.enum ["pipewire" "pulseaudio"];
      default = "pipewire";
      description = "Which sound server to use.";
    };
  };
}
