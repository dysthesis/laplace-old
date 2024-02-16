# This is mostly stolen from https://github.com/vimjoyer/nixconf/blob/main/myLib/default.nix
{inputs, ...}: let
  myLib = (import ./default.nix) {inherit inputs;};
  inherit (inputs.self) outputs;
in rec {
  # ======================= Package Helpers ======================== #

  pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

  # ========================== Buildables ========================== #

  mkSystem = sys: config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs myLib;
      };
      system = sys;
      modules = [
        config
        outputs.nixosModules.default
      ];
    };

  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor sys;
      extraSpecialArgs = {
        inherit inputs myLib outputs;
      };
      modules = [
        config
        outputs.homeManagerModules.default
      ];
    };
}
