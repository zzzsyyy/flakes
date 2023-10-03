{ stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "26.3.0";

  src = fetchurl {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/v${version}/Iosevka-${version}.tar.xz";
    hash = "sha256-BCiyTD9ZNkESxmvReKrPVzdHGrldr0gR/rWc+bXuVPc=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $_
  '';
}
