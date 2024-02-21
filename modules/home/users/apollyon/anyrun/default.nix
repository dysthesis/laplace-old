{
  inputs,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        translate
        symbols
        websearch
        inputs.anyrun-nixos-options.packages.${pkgs.system}.default
      ];

      # the x coordinate of the runner
      #x.relative = 800;
      # the y coordinate of the runner
      #y.absolute = 500.0;
      y.fraction = 0.02;

      # Hide match and plugin info icons
      hideIcons = false;

      # ignore exclusive zones, i.e. Waybar
      ignoreExclusiveZones = false;

      # Layer shell layer: Background, Bottom, Top, Overlay
      layer = "overlay";

      # Hide the plugin info panel
      hidePluginInfo = false;

      # Close window when a click outside the main box is received
      closeOnClick = false;

      # Show search results immediately when Anyrun starts
      showResultsImmediately = true;

      # Limit amount of entries shown in total
      maxEntries = 10;
    };

    extraCss = builtins.readFile ./configs/style.css;

    extraConfigFiles = {
      "applications.ron".text = builtins.readFile ./configs/applications.ron;
      "websearch.ron".text = builtins.readFile ./configs/websearch.ron;
      "dictionary.ron".text = builtins.readFile ./configs/dictionary.ron;
      "nixos-options.ron".text = let
        nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
        hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
        options = builtins.toJSON {
          ":nix" = [nixos-options];
          ":hm" = [hm-options];
        };
      in ''
        Config(
          options: ${options},
          min_score: 5,
          max_entries: Some(3),
        )
      '';
    };
  };

  home.packages = with pkgs; [
    sf-pro

    # dependency for the websearch plugin
    xdg-utils
  ];
}
