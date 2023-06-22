{ stdenvNoCC
, fetchzip
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "24.1.3-new";

  src = fetchzip {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/${version}/iosevka.zip";
    hash = "sha256-WAj8821u01pVM7cYFemTTCgjRLtCOHxed6wwb6+fxKk=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv iosevka-zt $out/share/fonts/truetype
  '';
}
