{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
    (self: super: {
      sf-pro = super.callPackage ../../../../pkgs/sf-pro {};
      georgia-pro = super.callPackage ../../../../pkgs/georgia-fonts {};
      cartograph-nf = super.callPackage ../../../../pkgs/cartograph-nf {};
      sugar-dark-sddm = super.callPackage ../../../../pkgs/sugar-dark-sddm {};
    })
  ];
}
