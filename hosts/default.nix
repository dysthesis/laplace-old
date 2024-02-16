{self, ...}: let
  inherit (self) inputs;

  # super simple boilerplate-reducing
  # lib with a bunch of functions
  myLib = import ./myLib/default.nix {inherit inputs;};
in
  with myLib; {
    nixosConfigurations = {
      phobos = mkSystem ./phobos;
    };
  }
