{ stdenvNoCC
, fetchzip
}:

stdenvNoCC.mkDerivation rec {
  pname = "iosevka-zt";
  version = "24.1.4";

  src = fetchzip {
    url = "https://github.com/zzzsyyy/Iosevka/releases/download/${version}/iosevka.zip";
    hash = "sha256-E11X8OXAZYY2Eog33vjeVbE/v1TYkFOhehSlmt+EFYc=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    mv iosevka-zt $_
  '';
}
