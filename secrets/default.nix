{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = {
    sops = {
      /*
      * The file defined below will contain our secrets.
      * sops-nix will encrypt it (AES-256-GCM), such that
      * it may be safely stored in a public repository, and
      * can only be decrypted with the defined Age keys.
      */
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";

      /*
      * This will tell sops-nix that it should locate the
      * required keys in my home directory's XDG_CONFIG.
      * There is likely a way to refactor this, such that
      * this option is defined per-host, as it is reasonable
      * to assume that each host will place this file on
      * different locations, at least on a standard setup.
      * However, this configuration is likely only ever be used
      * by me, no matter how many systems there end up being, so
      * it should be fine to define it this way, for now.
      */
      age.keyFile = "/nix/persist/etc/sops/age/keys.txt"; # The persisted /etc isn't mounted fast enough
    };
    environment =
      {
        systemPackages = [pkgs.sops];
      }
      // mkIf config.my.impermanence.enable {
        persistence."/nix/persist".directories = [
          "/etc/sops"
        ];
      };
  };
}
