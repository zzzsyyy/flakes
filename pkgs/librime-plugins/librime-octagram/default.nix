{  stdenv
,  lib
,  fetchFromGitHub
} :

stdenv.mkDerivation rec {
    pname = "librime-octagram";
    version = "a6ced5a1d623afed17284fbaa395dd3a8b019a14";

    src = fetchFromGitHub {
        owner = "lotem";
        repo = pname;
        rev = version;
        hash = "sha256-6HVRrEM0XG3F5hCOvP+lHwUbYA38KmEMiDa2JtofFHI=";
    };


    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
    '';
}
