{ source
, lib
, stdenvNoCC
, useGB ? false
}:

stdenvNoCC.mkDerivation rec {
  inherit (source) pname version src;

  sourceRoot = ".";

  unpackCmd = ''
    ttfName=$(basename $(stripHash $curSrc))
    cp $curSrc ./$ttfName
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv LXGWWenKaiScreen${lib.optionalString useGB "GB"}.ttf $_
  '';

  meta = with lib; {
    description = "LXGW WenKai for Screen Reading.";
    homepage = "https://github.com/lxgw/LxgwWenKai-Screen";
    license = licenses.ofl;
  };
}
