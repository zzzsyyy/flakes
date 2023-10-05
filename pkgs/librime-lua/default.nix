{ stdenv
, lib
, fetchFromGitHub
, lua5_4
}:

stdenv.mkDerivation rec {
  pname = "librime-lua";
  version = "ustable-2023-10-03";

  src = fetchFromGitHub {
    owner = "hchunhui";
    repo = pname;
    rev = "567102117662667061dc3c4c29fec3f59128d23e";
    hash = "sha256-8gylmGTIBcEywOa+Wij9u0ooPFqPYBO0k3WCk3JWmas=";
  };

  buildInputs = [ lua5_4 ];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';

  meta = with lib; {
    description = "Extending RIME with Lua scripts";
    homepage = "https://github.com/hchunhui/librime-lua";
    license = licenses.bsd3;
  };
}
