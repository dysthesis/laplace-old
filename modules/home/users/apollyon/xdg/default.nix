{pkgs, ...}: {
  imports = [
    ./mime-apps.nix
    ./user-dirs.nix
  ];

  xdg = {
    enable = true;
    mime.enable = true;
  };

  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
}
