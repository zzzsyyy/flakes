{ stdenvNoCC
, fetchurl
}:

let preurl = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project/releases/download";

in

stdenvNoCC.mkDerivation rec {
  pname = "plangothic";
  version = "0.8.5735";

  srcs = [
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP1-Regular.fallback.ttf";
      hash = "sha256-0HYLWHUvBO08Dh3ljB6Zwmx1xFA+7qCGQb822tadIEM=";
    })
    (fetchurl {
      url = "${preurl}/V${version}/PlangothicP2-Regular.ttf";
      hash = "sha256-2bXAd44FAf9laftKhSNehgUXJ8Kw7nr20Qpl/xTKBkA=";
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
