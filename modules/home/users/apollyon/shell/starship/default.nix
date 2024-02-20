{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      scan_timeout = 5;
      character = {
        error_symbol = "[󰊠](bold red)";
        success_symbol = "[󰊠](bold green)";
        vicmd_symbol = "[󰊠](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };
      git_commit = {commit_hash_length = 4;};
      line_break.disabled = false;
      lua.symbol = "[](blue) ";
      python.symbol = "[](blue) ";
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };
    };
  };
}
