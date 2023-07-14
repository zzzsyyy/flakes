{ lib
, stdenvNoCC
, fetchurl
, useGB ? false
}:

let
  preurl = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download";
in

stdenvNoCC.mkDerivation rec {
  pname = "lxgw-wenkai-screen";
  version = "1.300";

  src = fetchurl {
    url = "${preurl}/v${version}/LXGWWenKai${lib.optionalString useGB "GB"}Screen.ttf";
    hash = "sha256-+zq4DRtjgUXSBA7Fjr6a2zUTHAv27xtzIrfnY0RI58Q=";
  };

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
    description = "LXGW WenKai for Screen Reading.";
    homepage = "https://github.com/lxgw/LxgwWenKai-Screen";
    license = licenses.ofl;
  };
}
