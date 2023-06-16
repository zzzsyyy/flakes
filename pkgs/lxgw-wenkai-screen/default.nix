{ lib
, stdenvNoCC
, fetchurl
, useGB ? false
}:

stdenvNoCC.mkDerivation rec {
  pname = "lxgw-wenkai-screen";
  version = "1.300";

  src = fetchurl {
    url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v${version}/LXGWWenKai${lib.optionalString useGB "GB"}Screen.ttf";
    hash = "sha256-+zq4DRtjgUXSBA7Fjr6a2zUTHAv27xtzIrfnY0RI58Q=";
  };

  sourceRoot = ".";
  unpackCmd = ''
    ttfName=$(basename $(stripHash $curSrc))
    cp $curSrc ./$ttfName
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype
  '';
}
