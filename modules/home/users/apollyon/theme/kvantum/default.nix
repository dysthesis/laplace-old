{pkgs, ...}: {
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "GraphiteDark";
    };

    "Kvantum/Graphite" = {
      source = ./Graphite;
      recursive = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    breeze-icons
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];

  home.sessionVariables = {
    # scaling - 1 means no scaling
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # use wayland as the default backend, fallback to xcb if wayland is not available
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_STYLE_OVERRIDE = "kvantum";
    # disable window decorations everywhere
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # remain backwards compatible with qt5
    DISABLE_QT5_COMPAT = "0";

    # tell calibre to use the dark theme, because the light one hurts my eyes
    CALIBRE_USE_DARK_PALETTE = "1";
  };
}
