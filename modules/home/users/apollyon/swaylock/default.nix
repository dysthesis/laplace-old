{pkgs, ...}: {
  home.packages = with pkgs; [
    sf-pro
  ];
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      color = "#000000";
      font = "SF Pro Display";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "#000000";
      ring-color = "#89b4fa";
      inside-color = "#000000";
      key-hl-color = "#FFFFFF";
      separator-color = "00000000";
      text-color = "#FFFFFF";
      text-caps-lock-color = "";
      line-ver-color = "#FFFFFF";
      ring-ver-color = "#FFFFFF";
      inside-ver-color = "#000000";
      text-ver-color = "#cba6f7";
      ring-wrong-color = "#f38ba8";
      text-wrong-color = "#f38ba8";
      inside-wrong-color = "#000000";
      inside-clear-color = "#000000";
      text-clear-color = "#cba6f7";
      ring-clear-color = "#a6e3a1";
      line-clear-color = "#000000";
      line-wrong-color = "#000000";
      bs-hl-color = "#f38ba8";
      line-uses-ring = false;
      grace = 3;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%d/%m/%Y";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };
}
