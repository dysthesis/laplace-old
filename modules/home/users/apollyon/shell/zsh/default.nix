{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    sessionVariables = {LC_ALL = "en_AU.UTF-8";};
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["brackets"];
    };
    shellAliases = with pkgs; {
      ls = "${lib.getExe eza} --icons";
      ll = "${lib.getExe eza} --icons -l";
      la = "${lib.getExe eza} --icons -la";
      grep = "rg";
      cat = "bat";
      ccat = "cat";
      run = "nix run";
      nvim = "nix run github:dysthesis/poincare";
      rebuild = "sudo nixos-rebuild switch --flake /home/apollyon/Documents/NixOS";
      update = "nix flake update --commit-lock-file /home/apollyon/Documents/NixOS";
      doom = "~/.config/emacs/bin/doom";
    };

    history = {
      # share history between different zsh sessions
      share = true;
      # avoid cluttering $HOME with the histfile
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      # saves timestamps to the histfile
      extended = true;
      # optimize size of the histfile by avoiding duplicates
      # or commands we don't need remembered
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["rm *" "pkill *" "kill *"];
    };

    dirHashes = {
      docs = "$HOME/Documents";
      notes = "$HOME/Org";
      dots = "$HOME/Documents/NixOS";
      dl = "$HOME/Downloads";
      vids = "$HOME/Videos";
      music = "$HOME/Music";
      screenshots = "$HOME/Pictures/Screenshots";
    };

    loginExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        Hyprland
      fi
    '';

    completionInit = ''
         autoload -Uz compinit
         zstyle ':completion:*' menu select
         zmodload zsh/complist
         compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
         _comp_options+=(globdots)

         # Group matches and describe.
         zstyle ':completion:*' sort false
         zstyle ':completion:complete:*:options' sort false
         zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
         zstyle ':completion:*' special-dirs true
         zstyle ':completion:*' rehash true

         # open commands in $EDITOR
         autoload -z edit-command-line
         zle -N edit-command-line
         bindkey "^e" edit-command-line

         zstyle ':completion:*' menu yes select # search
         zstyle ':completion:*' list-grouped false
         zstyle ':completion:*' list-separator '''
         zstyle ':completion:*' group-name '''
         zstyle ':completion:*' verbose yes
         zstyle ':completion:*:matches' group 'yes'
         zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
         zstyle ':completion:*:messages' format '%d'
         zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
         zstyle ':completion:*:descriptions' format '[%d]'

         # Fuzzy match mistyped completions.
         zstyle ':completion:*' completer _complete _match _approximate
         zstyle ':completion:*:match:*' original only
         zstyle ':completion:*:approximate:*' max-errors 1 numeric

         # Don't complete unavailable commands.
         zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

         # Array completion element sorting.
         zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

         # Colors
         zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

         # Jobs id
         zstyle ':completion:*:jobs' numbers true
         zstyle ':completion:*:jobs' verbose true

         # Sort completions
         zstyle ":completion:*:git-checkout:*" sort false
         zstyle ':completion:*' file-sort modification
         zstyle ':completion:*:${lib.getExe pkgs.eza} --icons' sort false
         zstyle ':completion:files' sort false
      zstyle ':completion:*' insert-sections true

         # fzf-tab
         zstyle ':fzf-tab:complete:_zlua:*' query-string input
         zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
         zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
         zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
         zstyle ':fzf-tab:complete:cd:*' fzf-preview '${lib.getExe pkgs.eza} -1 --icons --color=always $realpath'
         zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
         zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    initExtraFirst = ''
         # set my zsh options, first things
      source ${./opts.zsh}
         set -k
         export FZF_DEFAULT_OPTS="
         --color gutter:-1
         --color bg:-1
         --color bg+:-1
         --color fg:#585b70
         --color fg+:#f5e0dc
         --color hl:#89b4fa
         --color hl+:#89b4fa
         --color header:#89b4fa
         --color info:#a6e3a1
         --color marker:#94e2d5
         --color pointer:#94e2d5
         --color prompt:#a6e3a1
         --color spinner:#94e2d5
         --color preview-bg:#181825
         --color preview-fg:#89b4fa
         --prompt ' '
         --pointer ''
         --layout=reverse
         -m --bind ctrl-space:toggle,pgup:preview-up,pgdn:preview-down
         "

         zmodload zsh/zle
         zmodload zsh/zpty
         zmodload zsh/complist

         # Colors
         autoload -Uz colors && colors

         # Autosuggest
         ZSH_AUTOSUGGEST_USE_ASYNC="true"

         # Vi mode
         bindkey -v

         # Use vim keys in tab complete menu:
         bindkey -M menuselect 'h' vi-backward-char
         bindkey -M menuselect 'k' vi-up-line-or-history
         bindkey -M menuselect 'l' vi-forward-char
         bindkey -M menuselect 'j' vi-down-line-or-history

         bindkey "^A" vi-beginning-of-line
         bindkey "^E" vi-end-of-line

         # If this is an xterm set the title to user@host:dir
         case "$TERM" in
         xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|kitty*)
           TERM_TITLE=$'\e]0;%n@%m: %1~\a'
             ;;
         *)
             ;;
         esac
    '';
    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "forgit"; # i forgit :skull:
        file = "share/forgit/forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "aa85792ec465ceee254be0e8e70d8703c7029f66";
          sha256 = "sha256-PGFYw7JbuYHOVycPlYcRItElcyuKEg2cGv4wn6In5Mo=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "b06e7574577cd729c629419a62029d31d0565a7a";
          sha256 = "sha256-ilUavAIWmLiMh2PumtErMCpOcR71ZMlQkKhVOTDdHZw=";
        };
      }
    ];
  };
  home.packages = with pkgs; [
    fzf
  ];
}
