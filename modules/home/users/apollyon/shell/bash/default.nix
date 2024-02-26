{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
       Hyprland
      fi
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
         then
           shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
           exec fish ''${LOGIN_OPTION}
      fi
    '';
  };
}
