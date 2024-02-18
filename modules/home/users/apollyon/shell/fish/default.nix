{
  pkgs,
  lib,
  ...
}: let
  eza = lib.getExe pkgs.eza;
in {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "bbaf29ae8ad30e1cb1c78d2c14814b1678022875";
          sha256 = "sha256-6ebzDQkpJNq7ZEmDeheek/OfMgbYH4wU3tf1QGgZr40=";
        };
      }
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
    ];
    shellAliases = {
      ls = "${eza} --icons";
      ll = "${eza} --icons -l";
      la = "${eza} --icons -la";
      gc = "git commit -am";
      ga = "git add -A";
      rebuild = "sudo nixos-rebuild switch --flake /home/apollyon/Documents/NixOS";
      update = "nix flake update --commit-lock-file /home/apollyon/Documents/NixOS";
      doom = "~/.config/emacs/bin/doom";
    };

    shellInit = ''
      set fish_greeting ""
    '';
  };

  # Some dependencies
  home.packages = with pkgs; [
    sqlite # For fzf
    fzf
  ];
}
