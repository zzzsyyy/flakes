{ stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "27.1.0";

  src = fetchurl {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/v${version}/Iosevka-${version}.tar.xz";
    hash = "sha256-jhF5qFlWHWSJLxSGFvK7/FJOccELPQ/x4vypR7JfdZE=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $_
  '';
}
