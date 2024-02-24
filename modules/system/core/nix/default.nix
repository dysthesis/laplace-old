{
  lib,
  pkgs,
  ...
}: {
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
  };
}
