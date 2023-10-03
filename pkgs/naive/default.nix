{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, glib
}:

stdenv.mkDerivation rec{
  pname = "naiveproxy";
  version = "117.0.5938.44-1";
  src = fetchurl {
    url = "https://github.com/klzgrad/${pname}/releases/download/v${version}/${pname}-v${version}-linux-x64.tar.xz";
    hash = "sha256-bIffHXJN7mtYRgBJPKymLdgnQ0naT8ZEyDzTAhP2J74=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    glib
  ];

  installPhase = ''
    install -m755 -D naive $out/bin/naive
  '';

  meta = with lib; {
    description = "Make a fortune quietly ";
    homepage = "https://github.com/klzgrad/naiveproxy";
    license = licenses.bsd3;
    platforms = platforms.linux;
    mainProgram = "naive";
  };
}
