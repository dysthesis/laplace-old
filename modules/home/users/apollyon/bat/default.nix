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
    sha256 = "0vys09k1jj8hv4ra4qvnrhwxhn48c2gxbxmagb3dyg7kywh49wvg";
  };
}
