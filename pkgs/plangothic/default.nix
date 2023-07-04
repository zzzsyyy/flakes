{ stdenvNoCC
, fetchurl
}:

let preurl = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project/releases/download";

in

stdenvNoCC.mkDerivation rec {
  pname = "plangothic";
  version = "0.8.5741"; #2023-06-13

  srcs = [
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP1-Regular.fallback.ttf";
      hash = "sha256-C5ggx/vNhnXMmvcul5u2RbraRfp9MH9/nnXSZuYuUV4=";
    })
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP2-Regular.ttf";
      hash = "sha256-obLY0DuKMzq/tl6Pi9aHtD5Uy2CrUlyC4FUU7ljDnpc=";
    })
  ];

  sourceRoot = ".";
  unpackCmd = ''
    ttfName=$(basename $(stripHash $curSrc))
    cp $curSrc ./$ttfName
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype/
  '';
}
