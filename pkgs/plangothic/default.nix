{  stdenvNoCC
,  fetchFromGitHub
} :

stdenvNoCC.mkDerivation rec {
    pname = "plangothic";
    version = "0.7.5720";
    src = fetchFromGitHub {
        repo = "Plangothic-Project";
        owner = "Fitzgerald-Porthmouth-Koenigsegg";
        rev = "V${version}";
        hash = "sha256-nqf8NCCDELNHZiGd6HESh3Z+UxX3tHaXhxfhgS3kDKU=";
    };

    installPhase = ''
        mkdir -p $out/share/fonts/truetype
        mv *.ttf $out/share/fonts/truetype
    '';
}
