{  stdenvNoCC
,  fetchurl
} :

stdenvNoCC.mkDerivation rec {
    pname = "my-fonts";
    version = "1.0";
    src = fetchurl {
        url = "https://codeberg.org/attachments/69fefc3c-1761-4b84-a311-cfc7e084daf4";
        name = "my-fonts${version}.tar.xz";
        hash = "sha256-ro/xC9z3Ssvq3JyYVKwkjEBCFESV2Vq1HnpesOShooo=";
    };
    sourceRoot = ".";

    installPhase = ''
        mkdir -p $out/share/fonts/opentype
        mkdir -p $out/share/fonts/truetype
        mv **/*.otf $out/share/fonts/opentype
        mv **/*.ttf $out/share/fonts/truetype
    '';
}
