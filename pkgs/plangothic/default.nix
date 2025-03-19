{
  source,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname src;
  version = lib.strings.removePrefix "V" source.version;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    install -Dm444 Plangothic.ttc $_
  '';

  meta = with lib; {
    description = "CJKV Unified Extension Area - Glyph Supplementation + Source Han Sans";
    homepage = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project";
    license = licenses.ofl;
  };
}
