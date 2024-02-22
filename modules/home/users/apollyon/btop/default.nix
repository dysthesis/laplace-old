{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
      theme_background = false;
      update_ms = 1000;
    };
  };
  xdg.configFile = {
    "btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/btop/c6469190f2ecf25f017d6120bf4e050e6b1d17af/themes/catppuccin_mocha.theme";
      hash = "sha256-TeaxAadm04h4c55aXYUdzHtFc7pb12e0wQmCjSymuug=";
    };
  };
}
