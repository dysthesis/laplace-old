{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "georgia-pro";
  version = "0.0.1";

  src = ./ttf;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Georgia Pro";
    platforms = platforms.all;
  };
}
