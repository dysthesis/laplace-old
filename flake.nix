{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # For managing user-space configurations
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For automating disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For managing persistence with ephemeral root
    impermanence.url = "github:nix-community/impermanence";

    # For secure boot shennanigans
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A better formatter for nix
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland stuff
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Doom is love, doom is life
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim
    nixvim = {
      url = "github:dysthesis/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    myLib = import ./lib/default.nix {inherit inputs;};
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    with myLib; {
      nixosConfigurations = {
        phobos = mkSystem "x86_64-linux" ./hosts/phobos;
      };
      nixosModules.default = ./modules/system;

      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "Laplace";
        meta.description = "The default development shell for my NixOS configuration";

        formatter = pkgs.alejandra;
        packages = with pkgs; [
          nil
          alejandra
          git
          lazygit
          glow
          statix
          deadnix
          ripgrep
          fd
          inputs.nixvim.packages.x86_64-linux.default
          fish
          starship
        ];
        shellHook = ''
          exec fish -C 'starship init fish | source'
        '';
      };
    };
}
