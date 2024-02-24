{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  # This adds the extraCompatPackages option so I don't have to manually install proton-ge
  imports = [inputs.nix-gaming.nixosModules.steamCompat];

  options.my.features.gaming.steam.enable = mkEnableOption "Whether or not to enable steam";

  config = mkIf config.my.features.gaming.steam.enable {
    nixpkgs.config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-original"
          "steam-runtime"
        ];
    };

    # enable steam
    programs.steam = {
      enable = true;
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = false;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = false;
      # Compatibility tools to install
      # this option used to be provided by modules/shared/nixos/steam
      # I removed it while porting it to nix-gaming
      # withProtonGE = true;
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
  };
}
