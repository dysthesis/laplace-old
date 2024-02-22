{pkgs, ...}: {
  imports = [
    ./mpv
  ];

  home.packages = with pkgs; [
    ani-cli
  ];
}
