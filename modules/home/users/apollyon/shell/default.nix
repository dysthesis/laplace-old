{pkgs, ...}: {
  imports = [
    ./bash
    #./fish
    ./starship
    ./zsh
  ];
  home.packages = with pkgs; [
    eza
    duf
  ];
}
