{
  pkgs,
  config,
  lib,
  ...
}: {
  # see https://github.com/luishfonseca/dotfiles/blob/main/modules/upgrade-diff.nix
  options.my.nix.nvd.enable = lib.mkEnableOption "Display diff after rebuild";
  config = lib.mkIf config.my.nix.nvd.enable {
    system.activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      '';
    };
  };
}
