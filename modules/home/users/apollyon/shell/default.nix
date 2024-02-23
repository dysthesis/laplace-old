{pkgs, ...}: {
  imports = [
    ./bash
    #./fish
    ./starship
    ./zsh
  ];
  home.packages = with pkgs; [
    du-dust
    eza
    duf
  ];
}
