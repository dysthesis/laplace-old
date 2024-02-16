{lib, ...}: {
  imports = [
    ./sudo.nix
    ./doas.nix
  ];
  options.my.security.privilege-elevation = lib.mkOption {
    type = lib.types.enum ["sudo" "doas"];
    default = "sudo";
    description = "Which security privilege elevation program to use.";
  };
}
