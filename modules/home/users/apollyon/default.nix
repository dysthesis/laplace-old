{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  # Let home-manager manage itself
  programs.home-manager.enable = true;
  home = {
    username = "apollyon";
    homeDirectory = "/home/apollyon";
    stateVersion = "23.11";
  };
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./hyprland
    ./wezterm
    ../../options
  ];
  myHome = {
    monitors = [
      {
        name = "DP-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        x = 0;
        y = 0;
      }
      {
        name = "DP-2";
        width = 1920;
        height = 1080;
        refreshRate = 165;
        x = 1920;
        y = 0;
      }
    ];
    wallpaper = ../../shared/wallpapers/wallhaven-6dwmmw.png;
  };
  home = {
    packages = with pkgs; [
      git
      freetube
      tor-browser
      signal-desktop
    ];
    persistence."/nix/persist/home/apollyon" = {
      allowOther = true;
      directories =
        [
          "Org"
          "Zotero"
          "Downloads"
          "Documents"
          "Music"
          "Pictures"
          ".ssh"
          ".gnupg"
        ]
        # .config directories to persist
        ++ forEach ["FreeTube" "emacs" "doom"] (x: ".config/${x}");
    };
  };
}
