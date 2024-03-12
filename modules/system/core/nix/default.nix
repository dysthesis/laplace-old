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
        /*
        * Our configurations are flake-based, so we need to
        * enable flakes here, of course.
        */
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };
    };

    nixpkgs.config = {
      /*
      * This particular configuration does not allow unfree software
      * by default, so any unfree software that needs to be installed
      * must be declared here.
      */
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "obsidian"
          "steam"
          "steam-original"
          "steam-runtime"
          "steam-run"
        ];

      /*
      * These are packages that are defined as insecure or deprecated upstream,
      * but we want/need to install them anyways. USE THIS VERY CAUTIOUSLY, AND
      * AVOID ADDING PACKAGES HERE AS MUCH AS POSSIBLE!
      */
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
