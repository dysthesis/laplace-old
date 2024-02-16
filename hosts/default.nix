{self, ...}: let
  inherit (self) inputs;
in
  with (import ../lib/default.nix inputs); {
    phobos = mkSystem "x86_64-linux" ./phobos;
  }
