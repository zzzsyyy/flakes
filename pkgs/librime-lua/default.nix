{ stdenv
, lib
, fetchFromGitHub
, lua5_4
}:

stdenv.mkDerivation rec {
  pname = "librime-lua";
  version = "20230625";

  src = fetchFromGitHub {
    owner = "hchunhui";
    repo = pname;
    rev = "c985eb399d63c491c6e03fa1651ddb59e485c04a";
    hash = "sha256-tpyX0NxAlNZ4Qeml2BeM0NbPN5xDW/uH/f0eqjBQKIM=";
  };

  buildInputs = [ lua5_4 ];

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
