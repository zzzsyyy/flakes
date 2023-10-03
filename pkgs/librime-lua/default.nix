{ stdenv
, lib
, fetchFromGitHub
, lua5_4
}:

stdenv.mkDerivation rec {
  pname = "librime-lua";
  version = "ustable-2023-09-14";

  src = fetchFromGitHub {
    owner = "hchunhui";
    repo = pname;
    rev = "7eca28fff386ad04b20a540bc8f99f90b2913869";
    hash = "sha256-xWByqSAnVJdrcRR9PR79ffXOhz8rOIvU2u5r0S29TKI=";
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
