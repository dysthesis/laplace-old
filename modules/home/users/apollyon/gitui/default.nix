{
  programs.gitui = {
    enable = true;
    theme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/gitui/main/theme/mocha.ron";
      hash = "sha256-TeaxAadm04h4c55aXYUdzHtFc7pb12e0wQmCjSymuug=";
    };
  };
}
