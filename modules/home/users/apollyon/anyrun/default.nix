{
  inputs,
  pkgs,
  ...
}: let
  sf-pro =
    pkgs.callPackage ../../../../../pkgs/sf-pro {};
in {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        translate
        randr
        shell
        symbols
        translate
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
      showResultsImmediately = false;

      # Limit amount of entries shown in total
      maxEntries = 10;
    };

    extraCss = ''
      * {
        color: #ffffff;
        font-family: SF Pro Display;
        font-size: 1rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match:selected {
        background: #A3CBE7;
      }

      #match {
        padding: 3px;
        border-radius: 8px;
      }

      #entry {
        border-radius: 8px;
      }

      box#main {
        background: #000000;
        border: 1px solid #ffffff;
        border-radius: 12px;
        padding: 8px;
      }

      row:first-child {
        margin-top: 6px;
      }
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from LibreWolf
          desktop_actions: true,
          max_entries: 10,
          // The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
          // to determine what terminal to use.
          terminal: Some("wezterm"),
        )
      '';

      "randr.ron".text = ''
        Config(
          prefix: ":ra",
          max_entries: 5,
        )
      '';

      "symbols.ron".text = ''
        Config(
          // The prefix that the search needs to begin with to yield symbol results
          prefix: ":sy",

          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            // "name": "text to be copied"
            "shrug": "¯\\_(ツ)_/¯",
          },

          // The number of entries to be displayed
          max_entries: 5,
        )
      '';

      "translate.ron".text = ''
        Config(
          prefix: ":tr",
          language_delimiter: ">",
          max_entries: 3,
        )
      '';
    };
  };

  home.packages = [
    sf-pro
  ];
}
