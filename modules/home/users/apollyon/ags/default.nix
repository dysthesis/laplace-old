{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    #ollama
    libnotify
    coreutils
    gjs
    pywal
    sassc
    ydotool
    gradience
    lexend
    poetry
    python311Packages.build
    python311Packages.pillow
    material-symbols
    playerctl
    ripgrep
    upower
    swayidle
    slurp
    webp-pixbuf-loader
    cava
    gojq
    gobject-introspection
    brightnessctl
    (python311.withPackages (p: [
      p.material-color-utilities
      p.pywayland
    ]))
  ];

  programs.ags = {
    enable = true;
    configDir = ./config; # if ags dir is managed by home-manager, it'll end up being read-only. not too cool.
    # configDir = ./.config/ags;

    extraPackages = with pkgs; [
      gtksourceview
    ];
  };
}
