{  stdenv
,  lib
,  fetchFromGitHub
,  lua5_4
} :

stdenv.mkDerivation rec {
    pname = "librime-lua";
    version = "0d8917b89dbab2c127f1887d2794e12b6383c3a";

    src = fetchFromGitHub {
        owner = "hchunhui";
        repo = pname;
        rev = version;
        hash = "sha256-sCbE9kYS0pyWdLsOJ9L3fBu3+nDmSw/ere9K7s9g9g4=";
    };

    buildInputs = [ lua5_4 ];

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
        chmod +w $out/src/types_ext.cc
        sed '127c return {}; auto t = (an<T>) c->Create(Ticket());' $src/src/types_ext.cc > $out/src/types_ext.cc
    '';
}
