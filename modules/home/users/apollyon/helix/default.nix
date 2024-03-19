{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default.overrideAttrs (old: {
      makeWrapperArgs = with pkgs;
        old.makeWrapperArgs
        or []
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath [
            clang-tools
            marksman
            nil
            nodePackages.bash-language-server
            nodePackages.vscode-langservers-extracted
            nodePackages.vscode-css-languageserver-bin
            shellcheck
          ])
        ];
    });

    settings = {
      theme = "catppuccin_mocha";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "X" = "extend_line_above";
        "esc" = ["collapse_selection" "keep_primary_selection"];
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":bc";
        "C-q" = ":xa";
        space.u = {
          f = ":format"; # Format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };
      keys.select = {
        "%" = "match_brackets";
      };

      editor = {
        color-modes = true;
        cursorline = true;
        line-number = "relative";
        completion-replace = true;
        true-color = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          left = [
            "mode"
            "selections"
            "spinner"
            "file-name"
            "total-line-numbers"
          ];
          center = [];
          right = [
            "diagnostics"
            "file-encoding"
            "file-line-ending"
            "file-type"
            "position-percentage"
            "position"
          ];
        };
      };
    };
    languages = {
      language = let
        deno = lang: {
          command = "${pkgs.deno}/bin/deno";
          args = ["fmt" "-" "--ext" lang];
        };
      in [
        {
          name = "markdown";
          auto-format = true;
          formatter = deno "md";
        }
      ];

      language-server = {
        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
          clangd.fallbackFlags = ["-std=c++2b"];
        };

        deno-lsp = {
          command = lib.getExe pkgs.deno;
          args = ["lsp"];
          environment.NO_COLOR = "1";
          config.deno = {
            enable = true;
            lint = true;
            unstable = true;
            suggest = {
              completeFunctionCalls = false;
              imports = {hosts."https://deno.land" = true;};
            };
            inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes = true;
              parameterNames.enabled = "all";
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enable = true;
              variableTypes.enable = true;
            };
          };
        };

        nil = {
          command = lib.getExe pkgs.nil;
          config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "--quiet"];
        };
      };
    };
  };
}
