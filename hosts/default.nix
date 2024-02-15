{self, ...}: let
  inherit (self) inputs lib;
in {
  phobos = lib.nixosSystem {
    system = "x86_64-linux";

    # Pass all the flake inputs here too.
    specialArgs = {inherit inputs;};
    modules = [
      ../modules
      ./phobos
    ];
  };
}
