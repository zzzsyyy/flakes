{ stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "my-fonts";
  version = "1.1";

  src = fetchurl {
    url = "https://codeberg.org/attachments/35f2b497-8af1-4712-8694-ce051374d36e";
    name = "my-fonts${version}.tar.xz";
    hash = "sha256-SGfzAE4ZTRQ7xW0nhXTFtNlvnLRCfUkFhUpn79awUVI=";
  };
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    #mkdir -p $out/share/fonts/truetype
    mv **/*.otf $out/share/fonts/opentype
    #mv **/*.ttf $out/share/fonts/truetype
  '';
}
