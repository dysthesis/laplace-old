{pkgs, ...}: {
  home.packages = with pkgs; [zsh-forgit gitflow];
  programs.git = {
    enable = true;
    userName = "Dysthesis";
    userEmail = "antheoraviel@protonmail.com";
    lfs.enable = true;
    delta.enable = true;
    signing = {
      key = "4F41D2DFD42D5568";
      signByDefault = true;
    };
    aliases = {
      c = "commit -am";
      s = "status";
      a = "add -A";
    };
  };
}
