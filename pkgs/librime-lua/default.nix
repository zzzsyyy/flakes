{ stdenv
, lib
, fetchFromGitHub
, lua5_4
}:

stdenv.mkDerivation rec {
  pname = "librime-lua";
  version = "20230115";

  src = fetchFromGitHub {
    owner = "hchunhui";
    repo = pname;
    rev = "03a2bd9e172549cb16c0718b2c9b68e8c5678085";
    hash = "sha256-3h1NfgdruFQJQGyvjfSH4mmOpcKFbJV5oDZEUK07ouE=";
  };

  buildInputs = [ lua5_4 ];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
