{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "sf-pro";
  version = "0.0.1";

  src = ./ttf;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp * $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "SF Pro fonts";
    platforms = platforms.all;
  };
}
