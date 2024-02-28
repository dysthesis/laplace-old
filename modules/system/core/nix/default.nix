{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./garbage-cleaning.nix
    ./nvd.nix
    ./overlays.nix
  ];

  config = {
    nix = {
      package = pkgs.nixFlakes;
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };
    };
    nixpkgs.config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
          "steam"
          "steam-original"
          "steam-runtime"
          "steam-run"
        ];
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };

    # Faster rebuilding. We always use web docs anyways.
    documentation = {
      doc.enable = false;
      nixos.enable = true;
      info.enable = false;
      man = {
        enable = mkDefault true;
        generateCaches = mkDefault true;
      };
    };
  };
}
