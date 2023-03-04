{ stdenvNoCC
, fetchurl
}:

let preurl = "https://github.com/Fitzgerald-Porthmouth-Koenigsegg/Plangothic-Project/releases/download";

in

stdenvNoCC.mkDerivation rec {
  pname = "plangothic";
  version = "0.8.5727";

  srcs = [
    (fetchurl {
      url = "${preurl}/V.${version}/PlangothicP1-Regular.fallback.ttf";
      sha256 = "sha256-XH4E3kSH6w84CdqNOL0nDfW9IfGaaiFj/fswaYiOs+w=";
    })
    (fetchurl {
      url = "${preurl}/V.${version}/PlangothicP2-Regular.ttf";
      sha256 = "sha256-R3ze/+VU+ove8999+IBIr4Rj7kSRhDuuOhhjK44W/tI=";
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
