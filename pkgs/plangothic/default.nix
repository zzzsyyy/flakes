{ lib
, stdenvNoCC
, fetchurl
}:

let
  preurl = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project/releases/download";
in

stdenvNoCC.mkDerivation rec {
  pname = "plangothic";
  version = "0.8.5744"; #2023-07-11

  srcs = [
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP1-Regular.fallback.ttf";
      hash = "sha256-zT4dadi6wp+HFz1rnT4g5XXpbJDXevXmqpKEXUcykRQ=";
    })
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP2-Regular.ttf";
      hash = "sha256-kmuK//M/UvHWc/bah9DdPBCe0CjbILPm7ljra0BvQv8=";
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
