{
  config,
  pkgs,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  options.my.users.apollyon.enable = lib.mkEnableOption "Enable the user 'Apollyon'";
  config = lib.mkIf config.my.users.apollyon.enable {
    users.users.apollyon = {
      description = "Apollyon";
      isNormalUser = true;
      shell = pkgs.zsh;
      hashedPassword = "$6$vpsdlBS0GxdQ8Fl.$6Pa3P6FvX6AvWHRNbPGh2NeeG8NalB5918DJ/J8s7R0oF9C7elqdPcpO6h9Frj75yWEpyxYW.PNLPu68jvvSg0";
      extraGroups =
        [
          "wheel"
          "video"
          "audio"
          "input"
          "nix"
          "networkmanager"
          "tss"
          "uinput"
          "libvirtd"
        ]
        ++ ifTheyExist [
          "network"
          "wireshark"
          "mysql"
          "docker"
          "podman"
          "git"
        ];
    };
    # Import the proper home-manager profile
    home-manager.users."apollyon" = import ../../../home/users/apollyon;
    programs.zsh.enable = true;
    # Bash is used as the default shell for POSIX compliance
    # but is configured to drop interactive sessions into fish.
    # programs.fish.enable = true;
  };
}
