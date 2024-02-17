{lib, ...}:
with lib; {
  options.myHome = {
    wallpaper = mkOption {
      default = ../shared/wallpapers/wallhaven-6dwmmw.png;
      type = types.path;
      description = "Path to the desired wallpaper";
    };
  };
}
