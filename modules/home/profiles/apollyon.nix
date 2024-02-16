{
  inputs,
  lib,
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
  ];
  home.persistence."/nix/persist/home/apollyon" = {
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
      ++ forEach ["emacs" "doom"] (x: ".config/${x}");
  };
}
