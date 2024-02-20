{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        vterm
        magit
        pdf-tools
        which-key
        company
        ripgrep
        python
        djvu
        preview-dvisvgm
      ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    ## Emacs itself
    binutils # native-comp needs 'as', provided by this
    # 28.2 + native-comp
    dash
    cmake

    fava # Web interface for Beancount
    shellcheck
    shfmt
    #graphviz
    nixfmt
    libclang
    glslang
    ## Doom dependencies
    git
    (ripgrep.override {withPCRE2 = true;})
    gnutls # for TLS connectivity

    ## Optional dependencies
    fd # faster projectile indexing
    imagemagick # for image-dired
    zstd # for undo-fu-session/undo-tree compression

    ## Module dependencies
    # :checkers spell
    (aspellWithDicts (ds: with ds; [en en-computers en-science]))
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    sqlite
    # :lang latex & :lang org (latex previews)
    texlive.combined.scheme-full
    # :lang beancount
    beancount

    # :lang haskell
    # haskell-language-server

    # :lang markdown
    pandoc

    # :lang org
    # graphviz

    # :lang rust
    cargo
    rustc
    rustfmt
    rust-analyzer
  ];
}
