{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
       Hyprland
      fi
    '';
  };
}
