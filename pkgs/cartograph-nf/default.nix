{
  lib,
  stdenvNoCC,
}: stdenvNoCC.mkDerivation {
  pname = "cartograph-nf";
  version = "0.0.1";

  src = ./fonts;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttf *.otf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cartograph CF";
    platforms = platforms.all;
  };
  }
