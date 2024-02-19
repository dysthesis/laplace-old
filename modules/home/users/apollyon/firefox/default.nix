{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
  ];
  # the home-manager module is too inflexible, at least for now...
  # programs.firefox = {
  #   enable = true;
  # };
  #
  #
  # imports = [
  #	 ./profiles
  # ];
}
