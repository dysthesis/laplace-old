{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme.override {
        tweaks = ["black" "rimless" "float"];
      };
    };

    iconTheme = {
      name = "Tela-black-dark";
      package = pkgs.tela-icon-theme;
    };

    font = {
      name = "SF Pro Display";
      size = 10;
      package = pkgs.sf-pro;
    };
  };

  home = {
    packages = with pkgs; [
      sf-pro
    ];
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
