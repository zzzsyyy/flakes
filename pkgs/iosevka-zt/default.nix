{ stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "26.0.2";

  src = fetchurl {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/v${version}/Iosevka-${version}.tar.xz";
    hash = "sha256-y3pGIFlr0Rlrw6eDzSxD26gF2sIeLdd75jmxUR9r5a0=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $_
  '';
}
