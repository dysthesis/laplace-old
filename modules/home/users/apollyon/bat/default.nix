{pkgs, ...}: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs; [
      bat-extras.batdiff
      bat-extras.batgrep
      bat-extras.batman
      bat-extras.batwatch
      bat-extras.prettybat
    ];
    config = {
      theme = "Catppuccin-mocha";
    };
  };
  xdg.configFile."bat/themes/Catppuccin-mocha.tmTheme".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/bat/ba4d16880d63e656acced2b7d4e034e4a93f74b1/Catppuccin-mocha.tmTheme";
    sha256 = "sha256:1z434yxjq95bbfs9lrhcy2y234k34hhj5frwmgmni6j8cqj0vi58";
  };
}
