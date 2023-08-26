{ lib
, stdenvNoCC
, fetchurl
}:

let
  preurl = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project/releases/download";
in

stdenvNoCC.mkDerivation rec {
  pname = "plangothic";
  version = "1.8.5746"; #2023-08-23

  srcs = [
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP1-Regular.fallback.ttf";
      hash = "sha256-/0eeOl7+i8bb3jSSrk8MTAjsOvOtxGtQuHsbGD2//oc=";
    })
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP2-Regular.ttf";
      hash = "sha256-8IsIsdRwsZb7JODpr7MDckgez0CcHiu7iPf6C6zsOwE=";
    })
  ];

  sourceRoot = ".";

  unpackCmd = ''
    ttfName=$(basename $(stripHash $curSrc))
    cp $curSrc ./$ttfName
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $_
  '';

  meta = with lib; {
    description = "CJKV Unified Extension Area - Glyph Supplementation + Source Han Sans";
    homepage = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project";
    license = licenses.ofl;
  };
}
