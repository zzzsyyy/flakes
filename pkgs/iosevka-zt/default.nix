{ stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "25.0.1";

  src = fetchurl {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/v${version}/Iosevka-${version}.tar.xz";
    hash = "sha256-rKxnWFHq7OKu/pzzwN7v2hHogMhOfMVXnJ9JR7mwSh4=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv *.ttf $_
  '';
}
