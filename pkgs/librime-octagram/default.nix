{ stdenv
, lib
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "librime-octagram";
  version = "20230125";

  src = fetchFromGitHub {
    owner = "lotem";
    repo = pname;
    rev = "a6ced5a1d623afed17284fbaa395dd3a8b019a14";
    hash = "sha256-6HVRrEM0XG3F5hCOvP+lHwUbYA38KmEMiDa2JtofFHI=";
  };


  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';

  meta = with lib; {
    description = "RIME octagram plugin";
    homepage = "https://github.com/lotem/librime-octagram";
    license = licenses.gpl3Only;
  };
}
