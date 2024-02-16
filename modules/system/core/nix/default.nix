{pkgs, ...}: {
  imports = [
    ./garbage-cleaning.nix
    ./nvd.nix
  ];

  config.nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };
}
